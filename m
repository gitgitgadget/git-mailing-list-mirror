From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list 
	available repositories
Date: Mon, 26 Jul 2010 15:32:39 -0700
Message-ID: <AANLkTin+EMYHrr11Dba9Mob+b_Dar_cedWmTsDF=AHFt@mail.gmail.com>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: j.sixt@viscovery.net, gitster@pobox.com, avarab@gmail.com,
	jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 00:32:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdWE3-0007fo-Uj
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 00:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483Ab0GZWcn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 18:32:43 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:46350 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752953Ab0GZWcm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 18:32:42 -0400
X-AuditID: 12074424-b7c35ae000000a07-7e-4c4e0d0b9e41
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id 67.A6.02567.B0D0E4C4; Mon, 26 Jul 2010 18:32:43 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o6QMWfgP005235
	for <git@vger.kernel.org>; Mon, 26 Jul 2010 18:32:41 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6QMWdRw024273
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 26 Jul 2010 18:32:40 -0400 (EDT)
Received: by iwn7 with SMTP id 7so3099954iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 15:32:39 -0700 (PDT)
Received: by 10.231.161.80 with SMTP id q16mr9365310ibx.142.1280183559429; 
	Mon, 26 Jul 2010 15:32:39 -0700 (PDT)
Received: by 10.231.144.140 with HTTP; Mon, 26 Jul 2010 15:32:39 -0700 (PDT)
In-Reply-To: <1279725355-23016-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAAhVGFPIVRtIh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151900>

Hi all,

Just sending a reminder about this patch series--I haven't seen any
comments on it yet, so I assume it's gotten lost in the flurry of
other list activity.

Thanks!

Greg



On Wed, Jul 21, 2010 at 8:15 AM, Greg Brockman <gdb@mit.edu> wrote:
> In this version, I fixed up the problems that Junio noted in my first
> patch. =A0Per Junio's comments on my second patch (git-shell-commands=
:
> Add a command to list bare repos), I added a README file in
> contrib/git-shell-commands. =A0I also squashed the commits creating
> files in that directory.
>
> I'll note that I realized (and documented in the README) that since
> commands are actually run out of $(cwd)/git-shell-commands, this migh=
t
> not do what the user expects if run outside of his or her home
> directory. =A0I'm not sure if this is bad behavior; do people have
> thoughts?
>
> Once again, thanks Junio for you comments.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
