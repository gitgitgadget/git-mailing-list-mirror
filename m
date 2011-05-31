From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [JGIT] Problem using API to create a repository in Amazon S3
Date: Tue, 31 May 2011 06:56:10 -0700
Message-ID: <BANLkTinh7RFW8aSVndrKZp4nmPw+fPBzUw@mail.gmail.com>
References: <1306833290555-6421952.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: DCWoods <dwoodsnz@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 15:56:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRPQz-0007jC-0x
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 15:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417Ab1EaN4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2011 09:56:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57420 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab1EaN4a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2011 09:56:30 -0400
Received: by gwaa18 with SMTP id a18so1763780gwa.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 06:56:30 -0700 (PDT)
Received: by 10.147.86.18 with SMTP id o18mr4974309yal.17.1306850190050; Tue,
 31 May 2011 06:56:30 -0700 (PDT)
Received: by 10.146.82.5 with HTTP; Tue, 31 May 2011 06:56:10 -0700 (PDT)
In-Reply-To: <1306833290555-6421952.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174802>

On Tue, May 31, 2011 at 02:14, DCWoods <dwoodsnz@gmail.com> wrote:
> I am writing an application that I want to be able to control git usi=
ng
> Amazon S3 for the storage. =A0I want the application to be able to cr=
eate a
> new git repository in S3, commit files that are created dynamically b=
y the
> application, and then later update and retrieve them.

You can't really use a repository on S3, you can only fetch from it or
push to it. So you would need to have a local repository that has a
copy of everything, work on the local repository, and at specific
"checkpoints" push the local repository to S3 for backups.

--=20
Shawn.
