From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: pack corruption post-mortem
Date: Wed, 16 Oct 2013 15:59:26 +0700
Message-ID: <CACsJy8CN6sOofVesHogk6Y9m0zHV31vyQr5HJZb9PTd-=DAyOw@mail.gmail.com>
References: <20131016083400.GA31266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 16 11:00:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWMxb-0006da-Av
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 11:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760573Ab3JPI77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 04:59:59 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34459 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760362Ab3JPI75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 04:59:57 -0400
Received: by mail-ob0-f172.google.com with SMTP id vb8so337653obc.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 01:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=giJOvM/8GFoEKHZ0+0rXnPHAJFfvvzc7Qxn+PFUqfzs=;
        b=r7p79HfZ6NKTWpT+0myc5kn1glJlCN4h+y/yaW87X+yulXB/9PchPL0W3um0JSNT0N
         vt1Kk2c2r+e2aFU1yK7vdBeMDlkHQDqiotzRhrGoIOLb3JTq2xS/7HL7Fnojs8SJFlNy
         wyMCAJf1zGPfBjcHux2sFyjY7vUyCZGX95TAZIA9MBuNppt1pdVhyvBZieBnuNLqlI30
         NTS0KgBI0tYBhetuvEOSaF+Hhvl5BQuWGOHOHtUMsMOTnNVTyl0cueDZ2WEhSU9L+xmE
         RxirlFOa+VVeFKfzJnGSsLubNbOnUQSp+/lBVYIHqBHOytMUugxvPVGF6XSjkuiefVfh
         LVUg==
X-Received: by 10.182.227.136 with SMTP id sa8mr2984337obc.39.1381913996503;
 Wed, 16 Oct 2013 01:59:56 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Wed, 16 Oct 2013 01:59:26 -0700 (PDT)
In-Reply-To: <20131016083400.GA31266@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236240>

On Wed, Oct 16, 2013 at 3:34 PM, Jeff King <peff@peff.net> wrote:
> I was recently presented with a repository with a corrupted packfile,
> and was asked if the data was recoverable. This post-mortem describes
> the steps I took to investigate and fix the problem. I thought others
> might find the process interesting, and it might help somebody in the
> same situation.

It's like reading an LWN article. Thank you.
-- 
Duy
