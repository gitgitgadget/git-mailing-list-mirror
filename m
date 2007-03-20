From: Andy Parkins <andyparkins@gmail.com>
Subject: Suspicious of v1.5.0 tag object
Date: Tue, 20 Mar 2007 13:23:12 +0000
Message-ID: <200703201323.15497.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 14:23:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTeJH-0006dd-RB
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 14:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbXCTNXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 09:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932806AbXCTNXW
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 09:23:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:47645 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932796AbXCTNXV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 09:23:21 -0400
Received: by nf-out-0910.google.com with SMTP id o25so353990nfa
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 06:23:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=c4QTWFTdEuMeXtDD/ocBf441xyy9Cm63XSmmw6cVelfZAMJuiJaihNAyD6D2ifAg5bAGeddAoxgIruAx1XI76PHpPhVPFYqfHZG+xl0nLmpoVAUsWrRhN0uAQdLLS4vs8dCLPTOVVlHmPpien0YspAb04wH0m3EXCbbbkKq5X+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YdVwf3B9nPNQCp+huBxUD7B6NVb2Jwm99vv95rHAe1iNeV2+NNiOu9Xi35SMDirdgTwVUHaXvyXNg2qpt1yXtDe5PiRvM2Vv1ANuaL0QNDDI5rcaIEDRg/2smEjPah1EUhqvrA4ecUKMM9nm+sGqj6e2Ew0SPjIdgmz1dqtT0qw=
Received: by 10.78.123.4 with SMTP id v4mr3086489huc.1174396999446;
        Tue, 20 Mar 2007 06:23:19 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id v20sm2037205nfc.2007.03.20.06.23.18;
        Tue, 20 Mar 2007 06:23:19 -0700 (PDT)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42740>

Hello,

I was just poking around and noticed this:

  $ git cat-file -p v1.5.0
  object 437b1b20df4b356c9342dac8d38849f24ef44f27
  type commit
  tag v1.5.0
  tagger Junio C Hamano <junkio@cox.net> Wed Feb 14 00:00:00 2007 +0000

Is it really the case that you tagged v1.5.0 at midnight UTC exactly; and that 
you travelled from your normal -0800 timezone to +0000?  None of the other 
tags show this strange output.

  $ git cat-file -p v1.5.0.2
  object 0d9b9ab1284ce125fd49cf7dbf4d28e0540cf035
  type commit
  tag v1.5.0.2
  tagger Junio C Hamano <junkio@cox.net> Mon Feb 26 00:26:21 2007 -0800

This looks much more normal.

Is the v1.5.0 tag object showing a bug? (The other possibility being that you 
did some clever messing to make it appear at exactly that moment)



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
