From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Tue, 22 Feb 2011 21:33:12 -0500
Message-ID: <4D6471E8.4060001@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com> <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com> <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com> <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com> <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino> <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com> <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com> <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com> <7voc69p4xu.fsf@alter.siamese.dyndns.org> <4D5F6E97.4000402@burntmail.com> <7vy65bkw72.fsf@alter.siamese.dyndns.org> <4D61EA4B.3020708@burntmail.com> <7vtyfxgdz2.fsf@alter.siamese.dyndns.org> <7vipwbbrcc.fsf@alter.siamese.dyndns.org> <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC
 -32@mail.gmail.com> <4D644FEE.5030004@burntmail.com> <7vaahnbmu2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 03:33:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps4Xw-0007st-2q
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 03:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855Ab1BWCd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 21:33:29 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:48295 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675Ab1BWCd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 21:33:28 -0500
Received: from [173.79.61.50] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.72)
	(envelope-from <guyr@burntmail.com>)
	id 1Ps4XU-0005NZ-Jd; Tue, 22 Feb 2011 20:33:16 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7vaahnbmu2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167672>

On 2/22/2011 7:45 PM, Junio C Hamano wrote:
> Guy Rouillier<guyr@burntmail.com>  writes:
>
>> To answer Junio's question, I'm looking at the CVSNT code now
>> (GlobalSettings.cpp, if anyone is interested.)  The password is stored
>> in a general fashion like any other user-specified value.  So, the
>> authors elected to use a properties file format of key=value.  That is
>> as valid a format as any other.
>
> As you dug that far, could you find out what happens when cvsroot contains
> an equal-sign character in its path component?
>
> I am starting to suspect that we do need two separate codepaths, and we
> would need to split out the logic to find matching password entry given a
> cvsroot value into a separate function to keep our sanity after all.
>

I'll take a look.  I spent a short amount of time with Google looking 
for "cvsroot valid characters" but didn't find anything authoritative. 
Note that this issue is not unique to CVSNT.  What does CVS do with 
CVSROOT containing a space character?

-- 
Guy Rouillier
