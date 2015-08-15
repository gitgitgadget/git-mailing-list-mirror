From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v10 04/13] utf8: add function to align a string into given strbuf
Date: Sat, 15 Aug 2015 15:27:32 +0700
Message-ID: <CACsJy8AFwcLZGQqg2Cv+fb2JBiZjh2tBpG4=8uxQdbUUmdZ-Pw@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com> <1439129506-9989-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 10:28:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQWpP-0005eO-Kw
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 10:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbbHOI2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 04:28:04 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37038 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbbHOI2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 04:28:02 -0400
Received: by igui7 with SMTP id i7so26246626igu.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SWQucPCQzezXYyT/idbXDJ75CHtEqNnkYUEcb3VduVs=;
        b=CDtR0z8/+EWFPMSRl51ojRsXy2j7xz0Io0l01E1PmmX6iFCq+4oKOb2TYBn08oy1ij
         hIUOqGa94+7lrR9m9hmhhEpjlfp7ih1hSAsJjDcOtOrkVTXdtc7qTkTm65eJDaxTdxXE
         ww1q7/TTaArWaGpqO4XlV5okaF2d15iYEXk09ih0rkus+7SpsApzRxEyCxThcD/68UBF
         40N2aqC8HOrHL7GUTKF5wIwHZagMxdFHt5dTZRR/Jn2LXGa4WJWaNyU/6daUNDxlzczl
         gy8l/eQQuRgXJytTDL3OZpVdeTQwcwQi5pf1oQqS3E+Da8+UA0OqYdn71vrEqTcay+kN
         XL4g==
X-Received: by 10.50.108.100 with SMTP id hj4mr7505773igb.65.1439627281605;
 Sat, 15 Aug 2015 01:28:01 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Sat, 15 Aug 2015 01:27:32 -0700 (PDT)
In-Reply-To: <1439129506-9989-5-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275983>

On Sun, Aug 9, 2015 at 9:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add strbuf_utf8_align() which will align a given string into a strbuf
> as per given align_type and width. If the width is greater than the
> string length then no alignment is performed.

I smell an opportunity to reuse this code and kill some in pretty.c's
format_and_pad_commit(). If you want, you can do it. Else this is my
personal note so I don't forget to do it later :)
-- 
Duy
