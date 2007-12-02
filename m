From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: make test failure with latest master
Date: Sun, 02 Dec 2007 18:19:17 -0500
Message-ID: <47533D75.1090002@gmail.com>
References: <4752A53E.4030000@gmail.com> <20071202163426.GA29781@coredump.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020701000503000707070300"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 00:19:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyy6C-0000kZ-MJ
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 00:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbXLBXTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 18:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbXLBXTY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 18:19:24 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:3920 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbXLBXTW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 18:19:22 -0500
Received: by wr-out-0506.google.com with SMTP id c49so2551897wra
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 15:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        bh=JFFI6NKk0iItf40D/JANaFAn1KalL5BXfh6J1vmGNeA=;
        b=ErsTBZyEQrd6nGjcIm2F7ctKdgA2ZRvS39qg78pUS7J3cJT+TKd+BOsRD1KUdzOZyRpGOwZyisrzD/0m8Amho3GtGX4h0okw6GA00EFiVcly9uNxMfNmO7V20H3i0jzXYz50qF8IJ5iXt5dH3esSHEqKyL278zEFLoKJvHQ0Afc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=DZFhYqHA345yw72Y7s4PkX37s2MTu9SGBjmP57HujfbKcnf85eGhlznWEY1tdT6pnKkt4n65zrzQLtKBosiouq5maOzhOkEW2YJ9HL8EY9Mh3cjjxif3RUKh7T/vPsyFl7TRnmaJwXBNR0Pg4VCCfB1NI9e45WDeTA+nKl29Z1E=
Received: by 10.70.75.12 with SMTP id x12mr3857848wxa.1196637561665;
        Sun, 02 Dec 2007 15:19:21 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id i14sm11366392wxd.2007.12.02.15.19.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Dec 2007 15:19:20 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20071202163426.GA29781@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66834>

This is a multi-part message in MIME format.
--------------020701000503000707070300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff King wrote:
> On Sun, Dec 02, 2007 at 07:29:50AM -0500, A Large Angry SCM wrote:
> 
>> With the latest master, 2221a6757161af1905925c405aded9ff470f70d5, "make 
>> test" now fails; last successful "make test" was mid-week sometime with 
>> master d25430. This is on a laptop running Suse 9.3.
>>
>> *** t9600-cvsimport.sh ***
>> *   ok 1: setup cvsroot
>> *   ok 2: setup a cvs module
>> * FAIL 3: import a trivial module
>>
>>
>>                 git cvsimport -a -z 0 -C module-git module &&
>>                 git diff module-cvs/o_fortuna module-git/o_fortuna
> 
> Can you please try ./t9600 --verbose? Presumably cvsimport is generating
> some kind of error message to tell us what's going on.

Attached is the output of

	./t9600-cvsimport.sh --verbose >/tmp/9600_out.txt 2>&1

--------------020701000503000707070300
Content-Type: text/plain;
 name="9600_out.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="9600_out.txt"

* expecting success: cvs init
*   ok 1: setup cvsroot

* expecting success: 

	mkdir $CVSROOT/module &&
	cvs co -d module-cvs module &&
	cd module-cvs &&
	cat <<EOF >o_fortuna &&
O Fortuna
velut luna
statu variabilis,

semper crescis
aut decrescis;
vita detestabilis

nunc obdurat
et tunc curat
ludo mentis aciem,

egestatem,
potestatem
dissolvit ut glaciem.
EOF
	cvs add o_fortuna &&
	cat <<EOF >message &&
add "O Fortuna" lyrics

These public domain lyrics make an excellent sample text.
EOF
	cvs commit -F message &&
	cd ..

cvs checkout: Updating module-cvs
cvs add: scheduling file `o_fortuna' for addition
cvs add: use `cvs commit' to add this file permanently
cvs commit: Examining .
/home/internet/GIT/git/t/trash/cvsroot/module/o_fortuna,v  <--  o_fortuna
initial revision: 1.1
*   ok 2: setup a cvs module

* expecting success: 

	git cvsimport -a -z 0 -C module-git module &&
	git diff module-cvs/o_fortuna module-git/o_fortuna


Initialized empty Git repository in /home/internet/GIT/git/t/trash/module-git/.git/

bad usage: invalid argument -A

Usage: cvsps [-h] [-x] [-u] [-z <fuzz>] [-g] [-s <range>[,<range>]]  
             [-a <author>] [-f <file>] [-d <date1> [-d <date2>]] 
             [-b <branch>]  [-l <regex>] [-r <tag> [-r <tag>]] 
             [-p <directory>] [-v] [-t] [--norc] [--summary-first]
             [--test-log <captured cvs log file>] [--bkcvs]
             [--no-rlog] [--diff-opts <option string>] [--cvs-direct]
             [--debuglvl <bitmask>] [-Z <compression>] [--root <cvsroot>]
             [<repository>] [-q]

Where:
  -h display this informative message
  -x ignore (and rebuild) cvsps.cache file
  -u update cvsps.cache file
  -z <fuzz> set the timestamp fuzz factor for identifying patch sets
  -g generate diffs of the selected patch sets
  -s <patch set>[-[<patch set>]][,<patch set>...] restrict patch sets by id
  -a <author> restrict output to patch sets created by author
  -f <file> restrict output to patch sets involving file
  -d <date1> -d <date2> if just one date specified, show
     revisions newer than date1.  If two dates specified,
     show revisions between two dates.
  -b <branch> restrict output to patch sets affecting history of branch
  -l <regex> restrict output to patch sets matching <regex> in log message
  -r <tag1> -r <tag2> if just one tag specified, show
     revisions since tag1. If two tags specified, show
     revisions between the two tags.
  -p <directory> output patch sets to individual files in <directory>
  -v show very verbose parsing messages
  -t show some brief memory usage statistics
  --norc when invoking cvs, ignore the .cvsrc file
  --summary-first when multiple patch sets are shown, put all summaries first
  --test-log <captured cvs log> supply a captured cvs log for testing
  --diff-opts <option string> supply special set of options to diff
  --bkcvs special hack for parsing the BK -> CVS log format
  --no-rlog disable rlog (it's faulty in some setups)
  --cvs-direct (--no-cvs-direct) enable (disable) built-in cvs client code
  --debuglvl <bitmask> enable various debug channels.
  -Z <compression> A value 1-9 which specifies amount of compression
  --root <cvsroot> specify cvsroot.  overrides env. and working directory
  -q be quiet about warnings
  <repository> apply cvsps to repository.  overrides working directory

cvsps version 2.0rc1

fatal: refs/heads/origin: not a valid SHA1
fatal: master: not a valid SHA1
warning: You appear to be on a branch yet to be born.
warning: Forcing checkout of HEAD.
fatal: just how do you expect me to merge 0 trees?
checkout failed: 256
* FAIL 3: import a trivial module
	
	
		git cvsimport -a -z 0 -C module-git module &&
		git diff module-cvs/o_fortuna module-git/o_fortuna
	
	

* expecting success: cd module-git && git gc && cd ..
Nothing new to pack.
*   ok 4: pack refs

* expecting success: 

	cd module-cvs &&
	cat <<EOF >o_fortuna &&
O Fortune,
like the moon
you are changeable,

ever waxing
and waning;
hateful life

first oppresses
and then soothes
as fancy takes it;

poverty
and power
it melts them like ice.
EOF
	cat <<EOF >message &&
translate to English

My Latin is terrible.
EOF
	cvs commit -F message &&
	cd ..

cvs commit: Examining .
/home/internet/GIT/git/t/trash/cvsroot/module/o_fortuna,v  <--  o_fortuna
new revision: 1.2; previous revision: 1.1
*   ok 5: update cvs module

* expecting success: 

	cd module-git &&
	git cvsimport -a -z 0 module &&
	git merge origin &&
	cd .. &&
	git diff module-cvs/o_fortuna module-git/o_fortuna


fatal: Needed a single revision
Branch 'origin' does not exist.
Either use the correct '-o branch' option,
or import to a new repository.
* FAIL 6: update git module
	
	
		cd module-git &&
		git cvsimport -a -z 0 module &&
		git merge origin &&
		cd .. &&
		git diff module-cvs/o_fortuna module-git/o_fortuna
	
	

* expecting success: 

	cd module-cvs &&
		echo 1 >tick &&
		cvs add tick &&
		cvs commit -m 1
	cd ..


./test-lib.sh: line 182: cd: module-cvs: No such file or directory
*   ok 7: update cvs module

* expecting success: 

	cd module-git &&
		git config cvsimport.module module &&
		git cvsimport -a -z0 &&
		git merge origin &&
	cd .. &&
	git diff module-cvs/tick module-git/tick


fatal: Needed a single revision
Branch 'origin' does not exist.
Either use the correct '-o branch' option,
or import to a new repository.
* FAIL 8: cvsimport.module config works
	
	
		cd module-git &&
			git config cvsimport.module module &&
			git cvsimport -a -z0 &&
			git merge origin &&
		cd .. &&
		git diff module-cvs/tick module-git/tick
	
	

* failed 3 among 8 test(s)

--------------020701000503000707070300--
