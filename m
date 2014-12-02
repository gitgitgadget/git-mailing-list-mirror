From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: http-protocol question
Date: Tue, 2 Dec 2014 12:30:44 +0700
Message-ID: <CACsJy8BtjM5CySt-V-bC3V9K1L2VQWT6pp=4fz8y6W_q1E8n6w@mail.gmail.com>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
 <20141202033416.GY6527@google.com> <CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
 <20141202044522.GZ6527@google.com> <CAGyf7-Gx1VU-1OicCHG0sStUnNXy_0Y8VYUP+PZjpN6nz7dTrw@mail.gmail.com>
 <20141202051755.GA6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 06:31:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvg3U-00067l-5n
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 06:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbaLBFbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 00:31:16 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:60572 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbaLBFbP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 00:31:15 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so14403197igi.6
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 21:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Mp+45eu0n8ZFhuqSXSA2QRROnIYYfplWQ0mgFlCICe4=;
        b=NLeG8xttmav9bt0BEnjbaQ9zJ2zxwB2QvaQiD4CvoVjvNccZobUDE3kHvvFS2c+VV7
         WVl+GhLPdF1w2XeYQVjZ5mkBVoZrxbW/AidrGQflE8yYkhKlyyHlEu+CfI7/eN3CUYmI
         8kNCJRDLKfAjYCUyTFisHVhh12fJ94qjAHNyIngBGG9WhoPlg88FFFNkMFwHKEdaL833
         KEjktrkcU2TKRpfd0kZybW8mJlXEVma0Z10JHGVyVjl+1cP2ifBTWvmVv3BA0vEquzeh
         krWPncqPnIhjymoDRhnoJdnthJVfhb2yfApQw492Gkg6DU/GBNZEAlazHfHgpYDaE1LZ
         6LoA==
X-Received: by 10.50.143.101 with SMTP id sd5mr1579207igb.40.1417498275040;
 Mon, 01 Dec 2014 21:31:15 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Mon, 1 Dec 2014 21:30:44 -0800 (PST)
In-Reply-To: <20141202051755.GA6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260535>

On Tue, Dec 2, 2014 at 12:17 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> On the server side, I agree that either mining reflogs or storing
> advertisements to disk would be a nice way to take care of this.
> No one has implemented either of those, but it would be a nice setting
> to have. :)

and could be dangerous too. If I accidentally add a password file,
then delete it (way before a clone is performed), I don't want that
part of reflog visible to the cloner. Problem is we don't know how far
we should look back in reflog unless we keep some state.
-- 
Duy
