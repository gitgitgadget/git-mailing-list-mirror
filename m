From: "Cameron McBride" <cameron.mcbride@gmail.com>
Subject: Re: git-cvsserver wart?
Date: Thu, 25 May 2006 23:24:53 -0400
Message-ID: <dcedf5e20605252024q5bf51486o7cbf6cc396b18b5d@mail.gmail.com>
References: <dcedf5e20605250942g6a7417dfh5f2f26df29842def@mail.gmail.com>
	 <46a038f90605251419kd45fbj419565eabdd63182@mail.gmail.com>
	 <dcedf5e20605252011v6738dc9dg3d4801144d3e9898@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri May 26 05:24:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjSwb-0007od-Bd
	for gcvg-git@gmane.org; Fri, 26 May 2006 05:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWEZDYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 23:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWEZDYz
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 23:24:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:22827 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030214AbWEZDYy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 23:24:54 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1958401wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 20:24:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FruvYM59fdgM3O9oBKHmCNx9/Bda8VOqSlXR7w0lqMec/i2nodbwfE+w2zNwtDTQPP5qJ6E4++jAqz0oXnFWB4YBPSGIxLtZlmBnl6Cseno4PGJeXom4OvWaH/x3AfuuaObk+G6sB+usb7fR1Et+TmYOKMXiOA39iIAc44DUeJw=
Received: by 10.64.24.20 with SMTP id 20mr1329927qbx;
        Thu, 25 May 2006 20:24:53 -0700 (PDT)
Received: by 10.65.53.4 with HTTP; Thu, 25 May 2006 20:24:53 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>, git@vger.kernel.org
In-Reply-To: <dcedf5e20605252011v6738dc9dg3d4801144d3e9898@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20786>

Does cvs commit upstream work?  In my testing, I can't get 'cvs ci' to
function on a git repo.

This seems to be broken with v1.3.3 and latest 1.3.3.ged90.  The cvs
clients are the same as before 1.11.1p1 and 1.11.17

The cvs client exits with:
Index already exists in git repo

The log (for git version 1.3.3.ged90):

INFO  - --------------- STARTING -----------------
DEBUG - Temporary directory is '/tmp/UvaWwud8fs'
DEBUG - req_Root : /export/home/cameron/ws/git_test/ntropy.git
DEBUG - req_Validresponses : ok error Valid-requests Checked-in
New-entry Checksum Copy-file Updated Created Update-existing Merged
Patched Rcs-diff Mode Mod-time Removed Remove-entry
Set-static-directory Clear-static-directory Set-sticky Clear-sticky
Template Set-checkin-prog Set-update-prog Notified Module-expansion
Wrapper-rcsOption M Mbinary E F MT               DEBUG -
req_validrequests
DEBUG - SEND : Valid-requests remove add status Entry watchers ci tag
log co Modified Questionable admin Root history valid-requests
Global_option Argumentx annotate Valid-responses Unchanged Directory
rlog Argument expand-modules diff editors update

                         DEBUG - SEND : ok
DEBUG - Argument : -m
DEBUG - Argument : ncsa mod
DEBUG - req_Directory : localdir=.
repository=/export/home/cameron/ws/git_test/ntropy.git/master path=
directory= module=master

 INFO  - Received entry line '/README/1.7///' => 'README'
DEBUG - Argument : README
INFO  - req_ci : [NULL]
WARN  - file 'index' already exists in the git repository

Let me know if any additional information is useful, I didn't have
much time to dig into this.

Cameron
