From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [Monotone-devel] Re: [RFC] mtn to git conversion script
Date: Thu, 28 Aug 2008 12:03:29 +0300
Message-ID: <94a0d4530808280203o6d97f69we4768115e12800c2@mail.gmail.com>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
	 <20080824131405.GJ23800@genesis.frugalware.org>
	 <94a0d4530808241133n5cc9f17arc79a1a5013187869@mail.gmail.com>
	 <20080824224658.GA16590@spearce.org>
	 <94a0d4530808241745r3f2bdb56q9cfa8bc61f79223e@mail.gmail.com>
	 <g95eoo$5ok$8@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: monotone-devel@nongnu.org, git@vger.kernel.org
To: "Anand Kumria" <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 11:04:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYdQh-00055y-IQ
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 11:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbYH1JDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 05:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbYH1JDb
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 05:03:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:21239 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbYH1JDa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 05:03:30 -0400
Received: by rv-out-0506.google.com with SMTP id k40so300084rvb.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 02:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ts66dNQAmcMeDkcxyobI377tffG3VpaXBlyay0rjbD8=;
        b=LVCdrsN4T0tqcL90TZBHBfF2xWN+kGwLpmT/n2D87N2nSx0BPZdC/FCbco3MY2EWHg
         sjtyihLkq1pz2O1IeDkcx3dePJ7QlvFTd9yJIDQGjqT5JOcKQI3VhevxKYCQ1959z7TS
         XExNa6yXq75Zr0jMT6KGFWEUITyrr7WZcACPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=coTKAkZKvced6MIWqaymjGH97J4J/x+No5O/D2qkdZ4qCDwmDI3sh2yWs9894GNz4O
         KD8awjDayXukAgAjVGW3oub6kJwrdMwMuBTUHoicrJT8zZNBzDbMoR7z1Rkhq1gyk2tG
         jSu56sHwyvbE/Y1GN9FOfbMjuy9vmKH4UbJpU=
Received: by 10.140.201.1 with SMTP id y1mr572909rvf.200.1219914209531;
        Thu, 28 Aug 2008 02:03:29 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Thu, 28 Aug 2008 02:03:29 -0700 (PDT)
In-Reply-To: <g95eoo$5ok$8@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 28, 2008 at 8:57 AM, Anand Kumria <wildfire@progsoc.org> wrote:
>
> Hi Felipe,
>
> On Mon, 25 Aug 2008 03:45:11 +0300, Felipe Contreras wrote:
>
>>
>> Anyway, very nice tool. It's going much faster (1h) compared to before
>> (1 day).
>
> Will you be submitting this as something for/to contrib?

Yes, that's the plan.

However, I still don't have something that creates an exact clone with
fast-import.

Also, I'm trying different ways to see what would be most efficient.
Right now it's a combination of Ruby + C, but once I get it working
I'll post it to the OE mailing lists to see if it works fine for them
too.

Once the design is good enough I might move everything to C.

Best regards.

-- 
Felipe Contreras
