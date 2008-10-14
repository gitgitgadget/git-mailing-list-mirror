From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Rerunning merge on a single file
Date: Tue, 14 Oct 2008 14:21:48 +0200
Message-ID: <adf1fd3d0810140521g7f43ee3bs5d4e60772bcc1d8c@mail.gmail.com>
References: <48F48CDB.1010309@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kristian Amlie" <kristian.amlie@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 14:23:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpivY-0003xW-4W
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 14:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbYJNMVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 08:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755415AbYJNMVu
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 08:21:50 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:35699 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445AbYJNMVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 08:21:49 -0400
Received: by gxk9 with SMTP id 9so4996690gxk.13
        for <git@vger.kernel.org>; Tue, 14 Oct 2008 05:21:48 -0700 (PDT)
Received: by 10.100.166.10 with SMTP id o10mr7174199ane.126.1223986908649;
        Tue, 14 Oct 2008 05:21:48 -0700 (PDT)
Received: by 10.100.112.16 with HTTP; Tue, 14 Oct 2008 05:21:48 -0700 (PDT)
In-Reply-To: <48F48CDB.1010309@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98184>

On Tue, Oct 14, 2008 at 2:13 PM, Kristian Amlie
<kristian.amlie@trolltech.com> wrote:
> Hey, I have question about advanced merging.
>
> Suppose I have a huge merge with conflicts all over the place. There is no
> way to avoid them, so I start working from the top. At some point, however,
> I make a mistake and lose the merge information for one file (for example by
> checking out the file from HEAD).
>
> In that case I would like to get the conflict markers back, and do that file
> over again, but I don't want to throw away the rest of the index state.
> Currently the only way I can see to do this is by checking out several file
> versions under different names and then using git merge-file on them.
>
> Is there a better way to achieve this?

If the different versions are still in the index you could use:

$ git checkout --merge $file

Santi
