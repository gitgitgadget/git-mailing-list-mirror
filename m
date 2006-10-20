From: Seth Falcon <sethfalcon@gmail.com>
Subject: problem with gitk --all on OSX, unknown option "-state"
Date: Fri, 20 Oct 2006 07:11:32 -0700
Message-ID: <m2wt6v9iwb.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 20 16:12:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gav5w-0004MD-QP
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWJTOLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWJTOL3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:11:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:50243 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751705AbWJTOL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 10:11:29 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1438163nfe
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 07:11:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=OTUhqriq9hd96RbGr9nlzxkCZelRCNiECdPpRG9j2xOYiJPcRIoYKXCpXLHSNDdEtae080ZMQQ4fCNySWYpipfj1IKC0iIIydOfoT6FelfvHWfL+tJ1YIk6hDcK6Ir/O3uBfjygH5L1WNjINsNShOAGHDVpt67jBFNC+R0L/O6I=
Received: by 10.48.210.20 with SMTP id i20mr368745nfg;
        Fri, 20 Oct 2006 07:11:27 -0700 (PDT)
Received: from ziti.fhcrc.org ( [67.171.24.140])
        by mx.google.com with ESMTP id a24sm1569218nfc.2006.10.20.07.11.26;
        Fri, 20 Oct 2006 07:11:27 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29472>

Hi,

On OSX (ppc 10.4.8), I'm unable to run gitk --all.  Without arguments,
gitk seems to work fine.  This is with git version 1.4.2.4.g3453.
There error message is surprising because the line before has:

    .bar.view entryconf 2 -state normal

and there is no complaint there about -state being unknown...


ziti:~/proj/bioc-2.0-git$ gitk --all 
Error in startup script: unknown option "-state"
    while executing
".bar.view entryconf 3 -state normal"
    invoked from within
"if {$cmdline_files ne {} || $revtreeargs ne {}} {
    # create a view for the files/dirs specified on the command line
    set curview 1
    set selec..."
    (file "/Users/seth/scm/bin/gitk" line 6283)


Thanks,

+ seth
