From: Stefan Beller <sbeller@google.com>
Subject: Re: Patch that modifies git usage message
Date: Fri, 1 May 2015 09:55:48 -0700
Message-ID: <CAGZ79kZcBSLhR1HBsHy2xgsGxp-Fwed1h-LBhSrXqKHp9XWQFw@mail.gmail.com>
References: <CAKB+oNtYbJXNb2wGzJCdQ5Ru5fq3HzcapSqiTVC_34=xDnTb7Q@mail.gmail.com>
	<CAGZ79kY1ZoYrVwVVqfyB+uMGsJo59qDxbDLgyo5qygSm=CUVhA@mail.gmail.com>
	<xmqqfv7gxnup.fsf@gitster.dls.corp.google.com>
	<CAKB+oNtKi6e7H9U75WEJDKH2KK349JT+vGE8+acHvM6SasCWfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 18:55:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoEED-0002QZ-WB
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 18:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbbEAQzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 12:55:49 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38683 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbEAQzs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 12:55:48 -0400
Received: by igbhj9 with SMTP id hj9so42708566igb.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oW1AoeVV/nOYSAxw9JEnFKfVFJilVRc9Uq0uV8Vmq5Y=;
        b=DVxucFNTVF+jKxshcUbXrPYESAhLMF3Dau7WWC6M6GUBpSQ3aUP+uNC0ykAZHlzulv
         6XI6uK5GLJTRU4nLuRluEV8VEEJY509IocZViIMeDRkRWOC1sNAMhEN5ojlQHKpQAg1N
         gqCBiqY9sbgXCxw7WmIKV0Ki+TATJpTHJ/SeP4mX67WHtCL8AIVhX4FQ0wbzDtixa2IU
         at4wA8znM9jgtsp2vwlBzI3kJ/DV/PXNDikId43CkKfOzGObLKO2Jj0wR3yqDQyybofh
         tIiU/ODf+7Ab33K6V92FKMk45/VeElcSmYEHAnTDiBtogZtf1e1UzVEFtobtxrYgq9tq
         797w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oW1AoeVV/nOYSAxw9JEnFKfVFJilVRc9Uq0uV8Vmq5Y=;
        b=Rtacd9M1vYLLAV3yd0hFVzoz8Yl6niyqUTsnlGr7G9QhUn04kA1TrN3XPRU+C6y50/
         q0Vkf30pQ/CNcr0ZPfqQ3F7Wq0KUIiYuLE7qvb3Jfy8PqqwhBYAhyiRaKVrkbcJCRocQ
         fy4dBID84QSTNn1Fdyy5Sfu1B19yZE2A8PQT6YrpObyM+lQxcPviPHQS7rLewKO2y63u
         Zq4Xbik7e8bAiOqnxO3xN0QoSOCTL3iBFT5LBJhr7ZCMmjpAE7q7yvH8P3+B48zutVwn
         eHfP2675u2bPazDHXpgBY5eogI9P6Zv+2jgryqSMr9RT3xgzZPs1zdVAPuugI/1XQxSO
         wOkA==
X-Gm-Message-State: ALoCoQnwgvzbl7Bxj7PiVZLbnA/+mL2Q1kE/tmyyVfQ2ToVObrPj6+c3S4NvFrSerpLV8wlvjfwn
X-Received: by 10.50.98.73 with SMTP id eg9mr11427394igb.10.1430499348373;
 Fri, 01 May 2015 09:55:48 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 1 May 2015 09:55:48 -0700 (PDT)
In-Reply-To: <CAKB+oNtKi6e7H9U75WEJDKH2KK349JT+vGE8+acHvM6SasCWfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268158>

On Fri, May 1, 2015 at 9:38 AM, Alangi Derick <alangiderick@gmail.com> wrote:
> Can't i change the "cannot" to "Cannot"? Or is there a problem with
> that one too?

Well maybe you can make a strong argument for changing it like you'd
find it inconsistencies in different spots.

If you're in the game just to change a thing or get a patch into Git,
you may want to look at
http://git-blame.blogspot.com/p/leftover-bits.html
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
(As you seem to focus on the textual UI, maybe
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#improve_.22git_help.22
might be a good idea to start with?)
