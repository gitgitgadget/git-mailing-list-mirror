From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 2/4] git-submodule: New subcommand 'summary' (2) - show commit summary
Date: Thu, 6 Mar 2008 19:36:50 +0800
Message-ID: <46dff0320803060336o4a28e4e0ve5a3f17e1323e171@mail.gmail.com>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
	 <1204481710-29791-2-git-send-email-pkufranky@gmail.com>
	 <7vk5kgiv0v.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803051816x5b957da0m6396d31cad8b4116@mail.gmail.com>
	 <7v3ar4lcgf.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803052156u374d70c1i45f7789233beb32c@mail.gmail.com>
	 <7vwsog9ls5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 12:37:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXEPn-0000V0-47
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 12:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbYCFLgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 06:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbYCFLgw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 06:36:52 -0500
Received: from hs-out-0708.google.com ([64.233.178.247]:32173 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbYCFLgv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 06:36:51 -0500
Received: by hs-out-0708.google.com with SMTP id 4so8065736hsl.5
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 03:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BGyk91OBw13nRegqtP6jRczBJhR/VbGXqs4C9wS9sPo=;
        b=JGcygTvubEbh8riYfXIuI0CQ7Le2bTpTPwo6am06ZhGqz9Of5ceN8eXCW1Xy6x8lWmlIb+60z1aZQ1FEA9/J6VdFXSR3qcgAWSmOVha4Lhjy7uvs81s0LRC7P7Zxq0ywMj6gY7dbI9lawypS/Ujo6oxSZ6a6r0o7k1CQ6ikIN+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iYl6acfKGCaZS3rFR0JHlnghQ8/GZ14jtSVo0j/6l4QFD19iImurv5UunpmjZ/GyHJxAHHsaqWCiFKsvIl8QQ+AKzA4ht3owU+SQZXFT+1m7W5lrqXOXwzDgrfMaR+af+HKP5B0dVVPzpI3fXtq15OfyAQrqxz25sEiBvoO4UfU=
Received: by 10.100.254.18 with SMTP id b18mr3491088ani.106.1204803410202;
        Thu, 06 Mar 2008 03:36:50 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Thu, 6 Mar 2008 03:36:50 -0800 (PST)
In-Reply-To: <7vwsog9ls5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76378>

On Thu, Mar 6, 2008 at 6:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>
> >>  Why would you want to see the bottom one?  I still don't understand.
>  >>
>  >>  And I do not mean this as a rhetorical question.  I am here to learn and
>  >>  I would like to make sure that I do not make a suggestion based on wrong
>  >>  understanding of what the user wants to see.
>  >>
>  >>  I probably am lacking imagination to think of a good use scenario that
>  >>  showing the bottom one would be useful to the user, and you as the author
>  >>  of this patch must thought about what the user want much more than me.
>  >>
>  > Showing the bottom one can give the user an impression where
>  > the submodules goes at first glance if the user is familiar with the
>  > developing progress of the submodule.
>
>  I think you are talking about the top one (the latest commit), and we both
>  know that is interesting information to show.  I was asking about the most
>  ancient one, which often is "Initial version of frotz."
>
Right, we have misunderstood each other in the 'bottom'  word. I thought
you propose to keep the initial one, and i said the latest one make much
sense than the initial one.

Now we agree on that keeping the latest commit is enough.



-- 
Ping Yin
