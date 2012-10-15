From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: Re: [PATCH 2/2] show color hints based on state of the git tree
Date: Mon, 15 Oct 2012 17:15:14 +0200
Message-ID: <507C2882.2090406@nieuwland.nl>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org> <20121005211030.GA5414@simaj.xs4all.nl> <507BC7F1.3080506@drmicha.warpmail.net> <507BD0EE.5000107@nieuwland.nl> <507BD3C1.4040807@drmicha.warpmail.net> <CAPc5daVUyAuznmrT+-yqvPR0gd38oiWmi2k+BFVV1s9ouMUt0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>, artagnon@gmail.com,
	spearce@spearce.org, schwab@linux-m68k.org, gitster@pobox.com,
	Simon Oosthoek <s.oosthoek@xs4all.nl>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 17:15:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNmOJ-0001vb-IK
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 17:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab2JOPP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 11:15:28 -0400
Received: from mail.nieuwland.nl ([87.251.35.136]:53475 "HELO nieuwland.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751131Ab2JOPP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 11:15:28 -0400
Received: (qmail 31014 invoked by uid 453); 15 Oct 2012 15:15:17 -0000
X-Virus-Checked: Checked by ClamAV on nieuwland.nl
Received: from Unknown (HELO [192.168.216.232]) (192.168.216.232)
  (smtp-auth username soosthoek, mechanism plain)
  by nieuwland.nl (qpsmtpd/0.83) with (AES256-SHA encrypted) ESMTPSA; Mon, 15 Oct 2012 17:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <CAPc5daVUyAuznmrT+-yqvPR0gd38oiWmi2k+BFVV1s9ouMUt0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207751>

On 10/15/2012 11:39 AM, Junio C Hamano wrote:
> Thanks for bringing some sanity to the color of the bikeshed ;-)
>
> As I don't use colors very much, I didn't bother checking the color
> assignment in the patch in question, but everything you said in your
> response makes 100% sense, including the traffic light analogy.
>

Hi Junio, Michael

The point of the thread and the patch was to enable the possibility of 
colors in the prompt without messing it up.

The actual colors used are more or less how I'm used to it, but as you 
said they may not be suitable to everyone.

@Junio, is this patch something you want to include as it is now (with 
the extra S that Michael pointed out) or do you want to wait for a 
discussion about which colors to use for which state?

I guess it could be quite a messy discussion, as you already hint at 
bikeshed colors, it's quite personal and subjective.

As a start, I think it's worth considering what the color would actually 
mean.

To me:
A neutral color should mean it's safe to switch branches or merge/update
A non-neutral color would mean some action is required before switching 
branches.
There are various states that may or may not get in the way of 
switching, like stashed stuff or divergence from upstream. I think these 
could get a color hint, but I'm not sure what kind.

Cheers

Simon
