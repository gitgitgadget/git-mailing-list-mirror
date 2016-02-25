From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v6 00/32] refs backend
Date: Fri, 26 Feb 2016 03:31:29 +0700
Message-ID: <CACsJy8D168eqdwvgLOeOtnD9FuiDLvUV2V9AVNFQPDVPUDZUww@mail.gmail.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
 <CACsJy8DEtmYnmwENws0Hb_2Do_sQkKEaraz=vxgrCyTOV-3FVg@mail.gmail.com> <1456428475.18017.38.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:32:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2a0-0006j9-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbcBYUcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:32:03 -0500
Received: from mail-lb0-f194.google.com ([209.85.217.194]:35276 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbcBYUcB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:32:01 -0500
Received: by mail-lb0-f194.google.com with SMTP id h2so2394425lbs.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 12:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YMJEpP5FtGOAz+Hi3PHGLykLBRX8gXkvP4Xh4/o+SYY=;
        b=k4w3mdBZp4SwCN1gl3Z9B99OchE1IQrvmRHj/R1XOwRDsRosTfEk8R8apgOD3j5nKt
         R3Y0cWYZz/Fh7kadZTXmZiKIV6w8U5SLEX0dM6SHJLbIbNwfyw9Yc7M+BsOmBURWtBZY
         melKrlDTm4KXJStF1wbNwdyaeUZmovYo83cdPdVnzBONn73yrVPf0BooyXuDfc9owIhG
         CznVKGbJZTfv81XNbM98eoSZ4z84iPULkZqgSVDO/31S4EwplbnyMo9dN0CyVMPKVYUg
         5LFU0vYGrN9ropBBaAs/m9BCn4MAKKPEqpzLrQ0cdiuj+SYo+/vhdqWzHKK4d0dYKvia
         TKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=YMJEpP5FtGOAz+Hi3PHGLykLBRX8gXkvP4Xh4/o+SYY=;
        b=UOHs3CVTy0Q2YdmgXm9HMqjer6shNgwqmW1fP0u+zcPLVzITHsBl5dsm+CzY8IcM23
         D6/Qpd9n40XlRvpj10eTYLtTKXlJfYydICbkrNB5iaR3A02eqBCH1i9SYrqBbDznNfea
         1hDSpBEkdcuB+101ubJpxpsrrLn1FQfe6QzcAZQ8jBxf7NLozidcatCC29DUALxA7u6x
         a3pZhHRkPeRBOUj0yEBvqVqmDx3xQRZLe/s0+5Aut5WxsFVveiafWKkzpVzW5IRQOSMX
         XGwACCImZQuiMHPUxxuHU/Gev3Wz/RPzG+9NSKgNSV8E5ei2nmZ2N/+gulMbqrqnqK57
         jnmg==
X-Gm-Message-State: AG10YOQK4Nrk0GOwiHNoYJ0X6V+ayhgJFN0xJXphavTtkcsyBa9G5eQViT3Iw+PNtv0M8I2d7uUppF9tvvtV9A==
X-Received: by 10.112.130.41 with SMTP id ob9mr17153820lbb.81.1456432319497;
 Thu, 25 Feb 2016 12:31:59 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 25 Feb 2016 12:31:29 -0800 (PST)
In-Reply-To: <1456428475.18017.38.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287434>

On Fri, Feb 26, 2016 at 2:27 AM, David Turner <dturner@twopensource.com> wrote:
> but -Wshadow produces a ton of complaints on the rest of git's
> code.   We should probably fix those.

I know, but what I wrote was meant for new code only (e.g. make
refs/lmdb-backend.o CFLAGS=-Wshadow is clean). I think renaming the
global env and transaction to the_env and the_transaction probably
does the trick. Again, this is controversial whether it's a good thing
to do. So your choice.
-- 
Duy
