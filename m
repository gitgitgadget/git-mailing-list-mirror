From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to non-GNU
 extended regex syntax
Date: Fri, 19 Sep 2008 10:59:20 -0500
Message-ID: <RvgrrcxK92TUU52XizpRyxykjZ7Bi6GV1bEGpjFUOlB7EfvuSDNySA@cipher.nrlssc.navy.mil>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org> <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil> <azRDXO9YgAHlqbMUTpBfy26HVw0xzYFwnT5x-l_nqDw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 18:02:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgiRG-0006MU-Ad
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 18:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbYISQB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbYISQB0
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 12:01:26 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53930 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbYISQB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 12:01:26 -0400
Received: by mail.nrlssc.navy.mil id m8JFxLig029451; Fri, 19 Sep 2008 10:59:21 -0500
In-Reply-To: <azRDXO9YgAHlqbMUTpBfy26HVw0xzYFwnT5x-l_nqDw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 Sep 2008 15:59:21.0032 (UTC) FILETIME=[ADBDB480:01C91A70]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96298>

Brandon Casey wrote:
> Brandon Casey wrote:
> 
>> +	{ "java", "!^[ 	]*(catch|do|for|if|instanceof|"
>> +			"new|return|switch|throw|while)\n"
>> +			"^[ 	]*(([ 	]*"
>> +			"[A-Za-z_][A-Za-z_0-9]*){2,}"
> 
> I don't understand the last two lines above.

ok, I figured it out.

I was interpretting the {2,} part in

  ([ 	]*[A-Za-z_][A-Za-z_0-9]*){2,}

as requiring two characters, instead of two or more repetitions of
the pattern inside the parenthesis.

-brandon
