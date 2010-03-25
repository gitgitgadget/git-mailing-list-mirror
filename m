From: "Tilo Schwarz" <tilo@tilo-schwarz.de>
Subject: Re: [PATCH RFC/RFD] clone: quell the progress report from init
Date: Thu, 25 Mar 2010 17:31:27 +0100
Message-ID: <op.u94tipqya8ed4e@dellschleppa>
References: <4BAB2234.4070202@drmicha.warpmail.net> <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
To: "git.vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 25 17:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nupy5-0008F0-Is
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 17:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab0CYQbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 12:31:32 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:16944 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab0CYQbb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 12:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1269534688; l=661;
	s=domk; d=tilo-schwarz.de;
	h=In-Reply-To:From:Content-Transfer-Encoding:MIME-Version:Date:
	References:Subject:To:Content-Type:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=R6FzVYTsxC2L/PTxr/6DS3hw73g=;
	b=xd/T3LZN/Cb6JLCA9WlF3TN0+Hn9Ho1N7tnFhvMCi0blWN3AbCoD/B3v0mYwwY0XTcM
	LNIE+a/s7kNdQngmd2qGo69EDasA04+bhUynk8A8IfbO2DvkqAm9safmC3AUb1hIKezf1
	ARH1ChsKE23GKxnSLZ9CUSMtWAHYMUQvm8Y=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlsZw1cxP8ao=
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CC8B0.dip.t-dialin.net [84.156.200.176])
	by post.strato.de (mrclete mo32) (RZmta 23.0)
	with ESMTP id V018ddm2PFlJEZ for <git@vger.kernel.org>;
	Thu, 25 Mar 2010 17:31:28 +0100 (MET)
In-Reply-To: <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net>
User-Agent: Opera Mail/10.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143184>

On Thu, 25 Mar 2010 09:46:16 +0100, Michael J Gruber  
<git@drmicha.warpmail.net> wrote:

> Currently, cloning a local repository results in the progress report
> "Initialized empty Git repository in ..." from init but no other output,
> leaving the user to wonder what happened to the actual cloning.

/me, (as just being an interested git user reading this list), likes this  
patch: As a Unix user I always wonder after a "git clone", why git tells  
me something about an "empty Git repository" (I think I saw the same  
message initializing submodules). I'd rather prefer no message, indicating  
the command completed with success.

Regards,

     Tilo
