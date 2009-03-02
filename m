From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] send-email: add --confirm option
Date: Mon, 2 Mar 2009 07:35:20 -0500
Message-ID: <76718490903020435t3b54863yc662a3e61e517087@mail.gmail.com>
References: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
	 <1235924234-16923-1-git-send-email-jaysoffian@gmail.com>
	 <7vwsb85qe9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 13:37:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le7O6-0005q2-Qb
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 13:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbZCBMfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 07:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbZCBMfX
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 07:35:23 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:53880 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZCBMfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 07:35:22 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2250371rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 04:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oQ7QZbAXDDGU2zO9LCQI4boeL4XQex+x/3l2mn+2sZg=;
        b=s0UUjlAkHx9EYPTPHwgoY3NkTEbIHfuERV3Z+HsU05P8GHuFh8G+9w5xZyN3Ee/17c
         R9S4/b40bb6ZSamf7nRcgzE0ju6Uze2mnqq4jxUgGUNWh4Y/5foXL/gqgChiLDcAKrDl
         bbTwhct9Vqs8WHjnXdDIRsdD5zHtyOv0Ks4pU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W1tASrrV5L9M6MRkS//Ovte/JfAkJzc6oX3TIOxIn5QBBbLIR4pd6kLy1giQ8Q7T61
         RXW4WcKGR7lm3gPdpgtvjTuI0ndP8suLZALQedJIJ4s67aH1bosb1oLM0qEyNDPTX8bq
         t5GqA2AQXbaGCz7VnyspRW5IY+99JFaDzP83k=
Received: by 10.141.176.6 with SMTP id d6mr2903839rvp.175.1235997320425; Mon, 
	02 Mar 2009 04:35:20 -0800 (PST)
In-Reply-To: <7vwsb85qe9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111934>

On Mon, Mar 2, 2009 at 2:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> In any case, with the lesson I learned from the post v1.6.0 fiasco, it
> might make sense to make the command louder when it needs to look at the
> setting of $confirm option and when the user does not have anything in the
> config nor command line.
>
> What I mean is this.

Okay, I'll re-send. Thanks for the feedback.

j.
