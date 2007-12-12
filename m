From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Wed, 12 Dec 2007 15:50:47 -0500
Message-ID: <7A812021-DCEC-49D4-895B-2DCBEFA7CA2E@yahoo.ca>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com> <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com> <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com> <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com> <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com> <20071212041002.GN14735@spearce.org> <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com> <20071212052329.GR14735@spearce.org> <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com> <Pine.LNX.4.64.0712121814260.27959@racer.site> <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com> <Pine.LNX.4.64.0712121931050.27959@racer.site> <7vk5nj7jkp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jason Sewall <jasonsewall@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 22:27:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Z6d-0003lq-94
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 22:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbXLLV0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 16:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbXLLV0k
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 16:26:40 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:48147 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751147AbXLLV0j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 16:26:39 -0500
Received: (qmail 62445 invoked from network); 12 Dec 2007 20:50:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=Wxs+YodEWr9RSxrFFcCSjVN172eNmDX7nfbtGuFU54DNlAZcncwERKXAKb2/w7MjzfniFq/mJW5EkgqBh1u6MLAx9wnRxSHpwKKlEE6jplFPs7Tt46z/TthWM966rTl+MnT2pv0MRzgGHcogfIb0btuYrak1vgf8xOiTbdsaE9I=  ;
Received: from unknown (HELO ?192.168.3.33?) (jean_francois_veillette@207.96.147.134 with plain)
  by smtp105.mail.mud.yahoo.com with SMTP; 12 Dec 2007 20:50:53 -0000
X-YMail-OSG: vbQrN9cVM1muMEvDcOiviN2UMayawJRm4.iqhVq7Zy8hhDwBN4.ZhpSKAP3stPeLXbpMNFZKJQ--
In-Reply-To: <7vk5nj7jkp.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68102>

> Well, the question was not very well stated.  I know what it means --
> remove that old line, without replacing with the corrected/updated  
> one.
> The real question is how would that be useful?

I often get big hunk just because I modified whitespaces around  
relevent pieces of code, the ability to segment the changes and only  
pick isolated and specific lines for a commit (not commiting  
whitespaces surrounding real code changes) would be very welcome.
Maybe I should know better, but the actual hunk selection in git gui  
is quite good already, but the ability to be more precise on how a  
hunk is defined is a welcome change.

- jfv
