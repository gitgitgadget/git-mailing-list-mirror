From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [QGIT PATCH/RFC]
Date: Thu, 5 Nov 2009 21:27:32 +0100
Message-ID: <e5bfff550911051227g257312b2idf729b9451d1bb@mail.gmail.com>
References: <4AF19630.2070402@lyx.org> <e5bfff550911050141t751d45a0r4e340fa0d10af366@mail.gmail.com> 
	<4AF2A538.7040303@lyx.org> <4AF2A69F.1090802@lyx.org> <4AF2AAFD.9000309@lyx.org> 
	<e5bfff550911051225s13c6e39dh355dc3ab1c0623f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Abdelrazak Younes <younes@lyx.org>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N68w3-0001lP-Ta
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 21:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758605AbZKEU1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 15:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758493AbZKEU1s
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 15:27:48 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:36393 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758494AbZKEU1r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 15:27:47 -0500
Received: by ey-out-2122.google.com with SMTP id 9so108518eyd.5
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 12:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=spc+o92GqhsXuCRpCSP0ggiyZprZnDFgEkGsj+gejqg=;
        b=U+6qFIooIv01WZoiuX7z8l3hj73r6fTigJMxlEG+C6XXTttAg3PHRn3QXF/6FLB9bV
         XaYo9qLHBswPw4IaYY1FCIzDlO+1FcAWUfZTmLPGuEsUf8zrrKurGK2b0Z2q6B2Byt7f
         NdwH/Y0Trb8c7RZ1nkXcKOy4pM4AuMETr9zDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZW1k/TvYZw5rKBEHnNy4l7vJCHTyREM6ndZ5S5nG1YFxH3tt87kpC2xvCyPXG90TYo
         EdsDqmPYmKDjC1BPBwvJXMOTw2h71FQG2cNRJ8dOCeIQJzIOOunDX3BZjVcjxJFM7Yur
         Y23l79cpy3+/4mWy5oxu+abPjFxooIQ1U2s08=
Received: by 10.213.100.138 with SMTP id y10mr3915261ebn.96.1257452872099; 
	Thu, 05 Nov 2009 12:27:52 -0800 (PST)
In-Reply-To: <e5bfff550911051225s13c6e39dh355dc3ab1c0623f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132245>

On Thu, Nov 5, 2009 at 21:25, Marco Costalba <mcostalba@gmail.com> wrote:
>
> When I tested I _found_ a speed difference, but now I don't remember
> of how much. Be sure you have warm cache when doing the test (press
> F5) for few times to be sure all is in RAM.
>

Sorry, I forgot.  Be sure also our custom hashing function is actually
called in your binary and the compiler didn't linked the Qt one
instead :-)
