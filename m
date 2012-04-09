From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 02/12] completion: simplify __gitcomp
Date: Mon, 09 Apr 2012 20:57:31 +0200
Message-ID: <4F83311B.50901@kdbg.org>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>	<1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>	<20120408124652.GN2289@goldbirke>	<CAMP44s0nSH7ZjC4T=7pXS2MyAkZ133hOXa_tn3q4er+FbcOc_w@mail.gmail.com>	<20120408132704.GB4103@burratino>	<CAMP44s3c2SNSh=TGhYv=JKGu4QJfPB_xoBip5wwLoDh3dLHYNw@mail.gmail.com>	<20120408143621.GA2631@burratino> <CAMP44s1hmG_xMjeB_Wv8pU=aPt=QK27R1OsePeeH5TK9w2GCqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:57:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJmW-0001BK-JH
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757560Ab2DIS5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 14:57:36 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:23124 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755044Ab2DIS5f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 14:57:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8E9F8130049;
	Mon,  9 Apr 2012 20:54:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4FA9519F6A1;
	Mon,  9 Apr 2012 20:57:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <CAMP44s1hmG_xMjeB_Wv8pU=aPt=QK27R1OsePeeH5TK9w2GCqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195029>

Am 08.04.2012 16:58, schrieb Felipe Contreras:
> On Sun, Apr 8, 2012 at 5:36 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> (dropping Shawn from cc since I'm not under the impression he works
>>  on the completion script these days)
>> Felipe Contreras wrote:
>>
>>> Whoa! Breaking their tab completion? Where? Can you show me some evidence?
>>
>> If you weren't listening before, I'm not sure what I can add now[*].
> 
> This is what you said; "in exchange for us breaking their tab
> completion". There's a big difference between "breaking", and
> "*potentially* breaking". I have never seen any evidence of tab
> completion actually being broken.

I have:

http://thread.gmane.org/gmane.comp.version-control.msysgit/13310/focus=13335
http://thread.gmane.org/gmane.comp.version-control.git/185184/focus=185189

-- Hannes
