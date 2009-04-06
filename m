From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [EGIT] [PATCH RFC v1 0/5] Add (static) ignore functionality to 
	EGit
Date: Mon, 6 Apr 2009 19:38:12 +0200
Message-ID: <fabb9a1e0904061038x657177beyf6686eb6683a971@mail.gmail.com>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl> 
	<20090405210248.GA23604@spearce.org> <49DA3305.7090601@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Apr 06 19:40:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqsnk-00056x-Df
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 19:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbZDFRib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 13:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbZDFRib
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 13:38:31 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:40338 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbZDFRia (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 13:38:30 -0400
Received: by bwz17 with SMTP id 17so1978960bwz.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8zlz1wFgR2j1VxaorOaTMeHQsM2+WPnUkVTqdMprX10=;
        b=og6eWgpQMP1CEf+lPO/H2xMiYv54ULOgLof4QpFukZVj5t5d4Mn5U/aYdp0mnLKONx
         HTDz4SeRucUg01D2Kjf2X5qDsKrhbCfy2xFt7aZR/U/48E3/O0+uDiqHzCxNZMCs3Lo+
         muWnM5tDue/TGbFJjEP5eKAi4ewczVPsFpwcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oy37lt7GM2V9+CFDUXsNbDq4/AbnkPHryaFc/fbpjWBOggL9wT37r276fF9NseT1x0
         92Gz8hZ0xSue+AO7ikN+sz76PUQrwLENh0GOzUUFVzIq7PuVUDOuClrGSXjR3E7pUKzP
         /6Llmzw02V5By4OHzXnVxFNVYUNDopWJL2b8E=
In-Reply-To: <49DA3305.7090601@pelagic.nl>
Received: by 10.204.115.143 with SMTP id i15mr1861424bkq.103.1239039507321; 
	Mon, 06 Apr 2009 10:38:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115857>

Heya,

On Mon, Apr 6, 2009 at 18:51, Ferry Huberts (Pelagic)
<ferry.huberts@pelagic.nl> wrote:
> just looked in the project settings for org.spearce.egit.core and it has
> java 1.5 style specified _and_ eclipse does not give me a warning on the
> *.isEmpty() calls. Am i missing something here?

FYI, notice the #since annotation in the JavaDoc [0].

[0] http://java.sun.com/javase/6/docs/api/java/lang/String.html#isEmpty()

-- 
Cheers,

Sverre Rabbelier
