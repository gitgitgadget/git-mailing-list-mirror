From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Fri, 1 Aug 2008 22:47:20 -0700
Message-ID: <C871A30D-F2AF-4385-ABD4-C57F474D7F01@sb.org>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com> <7vmyjxtco3.fsf@gitster.siamese.dyndns.org> <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com> <7v4p65tadh.fsf@gitster.siamese.dyndns.org> <0C57339C-50EF-4199-A14B-AFF04C92EF87@sb.org> <cb7bb73a0808012241s80a06fq1ac54a3350169f6c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 07:48:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP9yd-0008Uk-6l
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 07:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbYHBFr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 01:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbYHBFr0
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 01:47:26 -0400
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:52093 "EHLO
	randymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751688AbYHBFrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Aug 2008 01:47:25 -0400
Received: from [192.168.1.101] (c-76-103-51-229.hsd1.ca.comcast.net [76.103.51.229])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id 3C54990B44;
	Fri,  1 Aug 2008 22:47:24 -0700 (PDT)
In-Reply-To: <cb7bb73a0808012241s80a06fq1ac54a3350169f6c@mail.gmail.com>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91133>

On Aug 1, 2008, at 10:41 PM, Giuseppe Bilotta wrote:

> On Sat, Aug 2, 2008 at 2:31 AM, Kevin Ballard <kevin@sb.org> wrote:
>>
>> As a Ruby user, the regex for the funcname looks fine to me.
>
> What is your opinion about the anonymous code blocks?
>
> I've been thinking that another possibility could be to have two ruby
> funcnames, a simpler one (the one I presented) that only has 'named'
> blocks, and a more thorough one that also matches up anonymous blocks.
> User could then choose which one to use in their code by having
> gitattributes such as *.rb diff=ruby or *.rb diff=ruby-full (or
> whatever else).
>
> I'm not sure this would be a sensible policy though.

If you're going to get into anonymous code blocks, you're going to  
have a really tough time deciding which blocks are interesting and  
which aren't. And as you stated before, without a stack-based  
approach, this could really fall apart, as anonymous blocks are  
(almost) always going to be inside a method.

I think it's far simpler to stick with class/module/def.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
