From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 15:18:33 -0500
Message-ID: <76718490801231218i53c19e22lda34f2eec88627f8@mail.gmail.com>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	 <20080123000841.GA22704@mit.edu>
	 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
	 <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org>
	 <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	 <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
	 <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
	 <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Theodore Tso" <tytso@mit.edu>, "Mike Hommey" <mh@glandium.org>,
	git@vger.kernel.org
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:19:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHm42-0000dW-9f
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 21:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbYAWUSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 15:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbYAWUSg
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 15:18:36 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:21527 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbYAWUSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 15:18:35 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5249322wah.23
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 12:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OfxOqvn6Z4ZvxnIrq5B6MYLJPgxx74aILy5RGd92v2A=;
        b=fI8zvxW1wPmG0Ii8fRdKAKXK0eBrt5psn0blDve43n9INd5toDMPpzMoQOBtJQjSXCEqN7mNMPq2ZC7reYFXzLGzc5rJi5ICepE9npwoOZCSQLgyHQTv8kmIO6uVS+J0tUlXg7dKV3Ji2KundlxXb9HKZTHU9uUncul3KIZypBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bcrzXyFvL6Udcd86jNFZ4K5REiXkMq8XYBRftODpMK6yL8UBNZPP7NxUKsm+PR7vy3lz51LbMDM8QcSkhuFb5vWioCp+pcgIu03fZrHY/6PTo2ZXAdqfpVXl1ke9uc+WoeqPL8xhCkl/G8BSWYfEQKGDhV4uG4c2E3xMKhXCAsA=
Received: by 10.114.181.1 with SMTP id d1mr511799waf.10.1201119513357;
        Wed, 23 Jan 2008 12:18:33 -0800 (PST)
Received: by 10.114.14.17 with HTTP; Wed, 23 Jan 2008 12:18:33 -0800 (PST)
In-Reply-To: <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71567>

On 1/23/08, Kevin Ballard <kevin@sb.org> wrote:
>
> I don't get why you're still calling it corruption when, on an HFS+
> system, NFD-encoding is correct. It would be corruption for HFS+ to
> write anything else but NFD.

How about this: it's lossy. It's lossy in a similar sense that TIFF ->
JPEG -> TIFF doesn't give you back exactly the same bytes, even though
(modulo the compression level) the two TIFFs might be visually
indistinguishable.

You seem to have an issue with calling this "corruption", but to most
of us, if you have a system where you don't get back *exactly the same
data* that you put in, then the data has been corrupted.

Now, please stop trolling this point, agree to disagree, and either
contribute some code or be quiet and allow others to make progress.

j.
