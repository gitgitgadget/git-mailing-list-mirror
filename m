From: "J. Bakshi" <j.bakshi@unlimitedmail.org>
Subject: Re: pre-commit not working at server side push
Date: Wed, 20 Jul 2011 14:33:58 +0530
Message-ID: <201107200903.p6K93q7A019900@dcnode-02.unlimitedmail.net>
References: <20110720121356.4dc21f6b@shiva.selfip.org>
	<20110720124538.482628e3@shiva.selfip.org>
	<20110720073017.GA10465@LK-Perkele-VI.localdomain>
	<20110720131533.7bbba0c5@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Wed Jul 20 11:22:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjSzY-0005y7-3D
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 11:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187Ab1GTJWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 05:22:51 -0400
Received: from smtp.unlimitedmail.net ([94.127.184.244]:39002 "EHLO
	dcnode-02.unlimitedmail.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751072Ab1GTJWu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 05:22:50 -0400
X-Greylist: delayed 1101 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jul 2011 05:22:50 EDT
Received: from shiva.selfip.org (ABTS-North-Static-116.30.176.122.airtelbroadband.in [122.176.30.116] (may be forged))
	(authenticated bits=0)
	by dcnode-02.unlimitedmail.net (8.14.3/8.14.3) with ESMTP id p6K93q7A019900;
	Wed, 20 Jul 2011 11:03:55 +0200
In-Reply-To: <20110720131533.7bbba0c5@shiva.selfip.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAgMAAAAqbBEUAAAADFBMVEW2UCaWJQ3jnnRrCARshP4hAAACQElEQVQokRWSzU4aYRiFDwhiJjGAimxqRlzhbGpDm24wjmhTQtIIOlMag6GXUP92Tj5obcaaJqRJidvBlDi8N1FpbUzcFGgNK0MvgZKZsmHydVw+OWd1zgOiaH+98Ejt/SGCaTDlmZMYdl+cEmjMKQydBL97kJFAYlfbVab5KHS5AONrnoenPhVHbU1A4yezEYup+1crGRhtfuv9kPZtLRcz8Mw4ykJ1UPJF72Qkg09SdHFFxkY/iZW1HxNSY/zLSbS1B9sKLW7TaU3yB55DHXnjL4n0m1BSRNOZoKo8IXqx1YVqZ6is+C0YwS7Gml4q5/mdRFEbSkig95xbZEaHCMpEJ5x3yPRzyCEqzcTm0lMUscEEE0gfm/64RwPbpJyTIlPbLnNoMoku1JxNAHyTzhzQO2fWXL5PKgOD9H+fPQW4lUqnJk0OqkYEWorETE0SBzrmwFP0lj7Gn1r6qgZ4z8/jM/GVm7Mcg5apH4db8d43PccBoY6oHGAdPRuBX2m8DrSn+Y1+GALLNtLskjWFQHaEXsvMFvsFgc5sD4oyZT39wjiJQwu5ljRbSheqQnHIEfGfV2n+oL7KeBetvrcumQc1lbsQWJVj2fkDk/dceCwqi6qn4y7gcLxhlnCY71DgyGG4yNuvKnyPfBtzNipdRy6r/YXI9Pc+dM7WocqIHGU7KDlsSQn7wsHfSS9MVti9Dau5jfYkuU
 9Y13Z45+havZRg6H/Xhgk+au7c61L6FVD3XVu44IpkPpxUtnrqkiXRf3v/EFxxaZnHAAAAAElFTkSuQmCC
X-SOLTECSIS-MailScanner-ID: p6K93q7A019900
X-SOLTECSIS-MailScanner-From: j.bakshi@unlimitedmail.org
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177530>

On Wed, 20 Jul 2011 13:15:33 +0530
"J. Bakshi" <joydeep@infoservices.in> wrote:

> On Wed, 20 Jul 2011 10:30:17 +0300
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> 
> > On Wed, Jul 20, 2011 at 12:45:38PM +0530, J. Bakshi wrote:
> > > On Wed, 20 Jul 2011 12:13:56 +0530
> > > "J. Bakshi" <joydeep@infoservices.in> wrote:
> > > 
> > > > Hello list,
> > > > 
> > > > I have this bash script to check php syntax error and prevent the commit if there is any
> > > > 
> > > > ```````````````````
> > > > #!/bin/sh
> > > > 
> > > > ##php_syntax_check
> > > > 
> > > >   for i in $(git diff-index --name-only --cached HEAD -- | grep -E '\.(php|engine|theme|install|inc>
> > > >         if [ -f $i ]; then
> > > >                 output=$(/usr/bin/php5 -l $i)
> > > >                 if [ "$output" == "No syntax errors detected in $i" ];
> > > >                 then
> > > >                         echo "PHP syntax check for $i: OK"
> > > >                 else
> > > >                         echo "=====================================================================>
> > > >                         echo "Pause $i for the commit due to PHP parse errors:"
> > > >                         echo "$output"
> > > >                         exit 1
> > > >                 fi
> > > >         fi
> > > >     done
> > > > 
> > > > ```````````````````
> > 
> > > seems it should be pre-receive hook at the server. So done accordingly but still not working 
> > 
> > Pre-receive runs after objects have been received but before branches are updated. So
> > it can inspect the newly arrived commits but the branches retain their old values.
> > 
> > - Firstly, the server does not have index, so diff-index does not do anything sane.
> > - Secondly, HEAD does not point to anything newly arrived (the hook gets list of update 
> > instructions via stdin).
> > - Thirdly, this hook must be prepared for multiple commits in multiple branches appearing at
> > once.
> > 
> > I think githooks(5) documents what these hooks receive and what they do.
> > 
> > -Ilari
> 
> Thanks for your clarification. As a newbie I am interested to know any such pre-receive hook which can check php syntax before php.

The script given at the link below is working fine

http://git.661346.n2.nabble.com/Odd-results-writing-a-Git-pre-receive-hook-to-syntax-check-PHP-files-td5471120.html

But it doesn't show where the error is. The part actually checking the error is

``````````
function syntaxCheckFile($blob,$filename) { 
        $needle = '/(\.php|\.module|\.install)$/'; 
        if (preg_match($needle,$filename)) { 
                #echo "Checking $filename\n"; 
                $dummy = array(); 
                exec("git show $blob|/home/php/bin/php -l",$dummy,$checkrcval); 
                if ($checkrcval != 0) { 
                        echo "There was a syntax error in '$filename'. 
 Rejecting this attempted merge!\n"; 
                        exit(1); 
                } 
        } 
} 
``````````

can we modify it so that it shows the error too ?

PS: I am not a php guy
