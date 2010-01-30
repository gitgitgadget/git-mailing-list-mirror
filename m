From: David Rhodes Clymer <david@zettazebra.com>
Subject: Re: Custom git completion
Date: Sat, 30 Jan 2010 18:00:15 -0500
Message-ID: <9b69cfcf1001301500s48fcc476p1fd2c14e4310b892@mail.gmail.com>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
	 <20100129151127.GA21821@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 00:00:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbMIi-0008Tv-Bd
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 00:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab0A3XAR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 18:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462Ab0A3XAR
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 18:00:17 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:33817 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab0A3XAQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 18:00:16 -0500
Received: by pxi12 with SMTP id 12so2885582pxi.33
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 15:00:15 -0800 (PST)
Received: by 10.142.250.38 with SMTP id x38mr1757941wfh.345.1264892415443; 
	Sat, 30 Jan 2010 15:00:15 -0800 (PST)
In-Reply-To: <20100129151127.GA21821@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138515>

On Fri, Jan 29, 2010 at 10:11 AM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> David Rhodes Clymer <david@zettazebra.com> wrote:
>> Unless I read it incorrectly, the completion script included with
>> git-core does not make it easy for users to write completion scripts
>> for custom git commands. I can extend git itself by creating a comma=
nd
>> "git-foo", and placing it in my path.
>
> git config --global alias.foo /home/me/bin/my-git-foo
>
> git foo will now complete correctly. =A0No need to modify the
> completion code.

This doesn't do what I want. This workaround only allows the command
name itself to be completed. I want my _custom_ completion code  to be
used for my custom command.

-davidc
