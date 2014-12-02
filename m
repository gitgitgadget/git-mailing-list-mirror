From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: http-protocol question
Date: Tue, 2 Dec 2014 12:37:48 +0700
Message-ID: <CACsJy8B+b=SyhB3UX648drR2zxrn_3dfGQ9C21sELfABJfa2cQ@mail.gmail.com>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
 <20141202033416.GY6527@google.com> <CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
 <20141202044522.GZ6527@google.com> <CAGyf7-Gx1VU-1OicCHG0sStUnNXy_0Y8VYUP+PZjpN6nz7dTrw@mail.gmail.com>
 <20141202051755.GA6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 06:38:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvgAJ-0000DN-CW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 06:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbaLBFiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 00:38:19 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:40140 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbaLBFiT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 00:38:19 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so10942308iec.36
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 21:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BR45d4KQMEnhPYDhXN8dut6v1gvFsLCKa+8gO0FOnww=;
        b=H9NuQcFSNqAf1VmUPUtXNBcTp8lhJuDlJI3i1a6F+yTxM1GynunLQyzcMh8HDoSauQ
         NXYP35CJCr/9NDTQaEOQL45trNgqsPibKVY1N8qmOXkYIU2wqUeBppIqW6a4la8+tCGV
         ok73/knAxQkTIeI/DB228Z/OkH6kMRGPMxIGVFDSH6DYbJhjiOc7QDE9pS9W5zkhnHU7
         nkKck8IZhT/wi8daNL1p2mXdJ4zwiKHF8g3drqAEgTEiGUGWswAvWBCtZ93YJaySZ7if
         KOIhQRwNeuNIcnnAQLVY06Pk+nlncAzCk3egUI9agJYDB99KVyOcKy8xvr6Oynx7IcDg
         y3zw==
X-Received: by 10.107.135.34 with SMTP id j34mr54245143iod.84.1417498698513;
 Mon, 01 Dec 2014 21:38:18 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Mon, 1 Dec 2014 21:37:48 -0800 (PST)
In-Reply-To: <20141202051755.GA6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260537>

On Tue, Dec 2, 2014 at 12:17 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> I'm trying to decide if there is something I can enable or tune to
>> prevent it, and the type of twilighting hinted at by the http-protocol
>> documentation seemed like it could be just the thing.
>
> If you control the side that clones, then just cloning the single branch
> you are building (with --single-branch and -b) can help.

Or we could extend this a bit on the server side, if one ref fail, let
the clone continue with the remaining refs (and warn loudly to the
user).
-- 
Duy
