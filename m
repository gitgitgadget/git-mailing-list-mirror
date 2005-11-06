From: Marco Costalba <mcostalba@yahoo.it>
Subject: Check for differents trees
Date: Sun, 6 Nov 2005 07:38:30 -0800 (PST)
Message-ID: <20051106153830.18963.qmail@web26312.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Nov 06 16:40:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYmbP-0000r0-H5
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 16:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVKFPih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 10:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVKFPih
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 10:38:37 -0500
Received: from web26312.mail.ukl.yahoo.com ([217.146.177.49]:53860 "HELO
	web26312.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932083AbVKFPig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 10:38:36 -0500
Received: (qmail 18965 invoked by uid 60001); 6 Nov 2005 15:38:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hxWGQT/3HEfTkhjumwBwdRVcvgR3FexI9gK9D679FcFf4SO2CuGt/dO7eNQi1mDc3xjetxbMfZ9PtsSSZhktTil6VaidjSwShljWKo00p5Poc1mJDKSY+26iDEaxAumgg5OzPwfyZgu/TF1vQEUlPA+kha2ph1wym/v6Wiaxvno=  ;
Received: from [151.44.24.164] by web26312.mail.ukl.yahoo.com via HTTP; Sun, 06 Nov 2005 07:38:30 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11215>

Hi all,

   I need to check as fast as possible if two given trees (sha1 and sha2) have the same files.

What I use now is:

git-diff-tree -r --name-status sha1 sha2

An then I parse the output for 'A' or 'D' as first char of each line. When I found one of that two
chars I kwnow trees have different files set.

The problem is that if sha1 and sha2 correspond to very "distant" revision the output of
git-diff-tree can be very long and also usless as long as I stop searching at first match.

My question is if there is a better way, with the constrain of _not_ use a pipe of commands
like git-diff-tree....| grep something.

The constrain belong from Qt process class that is not very friendly with shells.

Thanks for any help
Marco
 




		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
