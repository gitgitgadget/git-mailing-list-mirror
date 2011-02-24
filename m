From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Wed, 23 Feb 2011 22:14:26 -0500
Message-ID: <4D65CD12.3070903@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com> <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com> <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com> <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com> <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino> <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com> <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com> <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com> <7voc69p4xu.fsf@alter.siamese.dyndns.org> <4D5F6E97.4000402@burntmail.com> <7vy65bkw72.fsf@alter.siamese.dyndns.org> <4D61EA4B.3020708@burntmail.com> <7vtyfxgdz2.fsf@alter.siamese.dyndns.org> <7vipwbbrcc.fsf@alter.siamese.dyndns.org> <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC
 -32@mail.gmail.com> <7vei6zbmz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 04:15:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsRff-0002LS-Hv
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 04:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302Ab1BXDPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 22:15:11 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:33854 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298Ab1BXDPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 22:15:09 -0500
Received: from [173.79.61.50] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.72)
	(envelope-from <guyr@burntmail.com>)
	id 1PsRev-0001A1-Rg; Wed, 23 Feb 2011 21:14:29 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7vei6zbmz8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167772>

On 2/22/2011 7:42 PM, Junio C Hamano wrote:
> Martin Langhoff<martin@laptop.org>  writes:
>
>> On Tue, Feb 22, 2011 at 6:08 PM, Junio C Hamano<gitster@pobox.com>  wrote:
>>> Even though I don't deeply care about what CVSNT does...
>> ...
>>> Does anybody know why?  Only to make things incompatible, perhaps? ;-)
>>
>> A brief googling around shows that it also stores it in the Windows registry.
>
> Yes, I saw that too.  I actually also got the impression that registry is
> the primary location for cvsnt (hence I suspect .cvs/cvspass support might
> be secondary and would not be surprised if it were sub-par).

There may perhaps be a misunderstanding of CVSNT.  CVSNT is a 
multi-platform client and server.  Both parts can run on many platforms, 
including Windows, Linux, and Solaris.  I don't use Macs so don't know 
about them.

Use of HOME/.cvs/cvspass is not secondary or sub-par.  On any platform 
other than Windows, HOME/.cvs/cvspass is the standard place that CVSNT 
stores repository passwords.  And on Windows, you can optionally tell it 
to store repository passwords in HOME/.cvs/cvspass instead of the 
registry.  I have my Windows configured that way for consistency with my 
numerous Linux accounts.

The whole reason I resurrected this 2 year old topic is that we are 
trying to migrate from CVSNT on *Linux* to git.

Thanks.

-- 
Guy Rouillier
