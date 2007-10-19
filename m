From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Fri, 19 Oct 2007 12:24:44 +1000
Message-ID: <ee77f5c20710181924j7c538468r75f0f17968af7b01@mail.gmail.com>
References: <20071019004527.GA12930@spearce.org>
	 <20071019021255.GD3290@coredump.intra.peff.net>
	 <47181430.2080907@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Nicolas Pitre" <nico@cam.org>
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:24:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihXm-0000Zz-Q2
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763178AbXJSCYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763030AbXJSCYq
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:24:46 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:35140 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758959AbXJSCYq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:24:46 -0400
Received: by rv-out-0910.google.com with SMTP id k20so329470rvb
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 19:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=miTIN4o7WW+kw88TuSHyVac9dErz8nxkmFuYEu/xn7k=;
        b=ZGU8BbEjAEQGu/0cHC84sYeqqYhB9J+UZe7R15dQPOLuL11lEa/90tiGg2mVKdYqIteUWW8kvA+9I2AVVqK1zU0OZzl1pvVk3i0+smotj+RHTtqfqO82ZIy+1x3yzh2Wp8GiRZ58M/SPzw8kSVCRC+Lsbso7uXB4T5k5sR5eQrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eOD3HZXJdR6Vp0LRXRO/rL1736yoWg6IH9AQWtAbn3NMCJtYkwleZ1jAsNI9sUWZ+z+/ng76ur9SN8MWIr5mWaNfPynSW5YNzB/OicPONPnath6avlO4scWtphAInOIIUU9N9JgBCPZnR4w664nE/ZFdPSzgRETqPTlju1v51G8=
Received: by 10.141.21.19 with SMTP id y19mr695306rvi.1192760684636;
        Thu, 18 Oct 2007 19:24:44 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Thu, 18 Oct 2007 19:24:44 -0700 (PDT)
In-Reply-To: <47181430.2080907@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61606>

On 19/10/2007, Sam Vilain <sam@vilain.net> wrote:
> Jeff King wrote:
> > Boo. I _like_ "deltifying". Sure, it's probably not in the dictionary,
> > but that's how languages change: saying "delta compressing" all the time
> > will get awkward, so people invent a new word using existing rules to
> > explain a common phenomenon.
>
> This is not very considerate to non-native speakers, though, who might
> not grasp the neogolism.
>
> Perhaps just "compressing" if it gets awkward.

Forward thinking, that's probably most sensible, since git 4.7 might
not use delta compression, but maybe wavelet compression, or other
scheme entirely. Using deltas is an implementation detail, after all.


Dave.
