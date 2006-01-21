From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Sat, 21 Jan 2006 18:24:05 +0000
Message-ID: <b0943d9e0601211024s76528ce8m@mail.gmail.com>
References: <1137144291.20073.104.camel@dv>
	 <b0943d9e0601160018x206faf9ck@mail.gmail.com>
	 <1137517300.20556.26.camel@dv> <20060117215752.GH32585@nowhere.earth>
	 <1137539762.12454.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Yann Dirson <ydirson@altern.org>, git <git@vger.kernel.org>,
	Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Sat Jan 21 19:24:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0NPI-0007bC-Dx
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 19:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWAUSYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 13:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWAUSYJ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 13:24:09 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:7794 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932226AbWAUSYI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 13:24:08 -0500
Received: by xproxy.gmail.com with SMTP id i30so456888wxd
        for <git@vger.kernel.org>; Sat, 21 Jan 2006 10:24:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KnuIlporsAr4/gmvsZQmSQPhDLYGmo8BYFmC9Fy6h9EA4McTd4KMpf7Qg0186bmhC7ZwJlHzskUe/4zygYYh+9xmbzvk7/yUEUPIseSHIJ4rtpD8Kt0BsqojcEpQUNhQWW/nsFc6sV9/6hGoXNphtrYcC5oD+N3OwTbcjcYmnUU=
Received: by 10.70.60.17 with SMTP id i17mr3772528wxa;
        Sat, 21 Jan 2006 10:24:05 -0800 (PST)
Received: by 10.70.53.11 with HTTP; Sat, 21 Jan 2006 10:24:05 -0800 (PST)
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1137539762.12454.11.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14999>

On 17/01/06, Pavel Roskin <proski@gnu.org> wrote:
> I think if would be better to improve "stg fold" to work on arbitrary
> patches.  This way, you prepare the patch in the editor (which would not
> be harder than finding hunk numbers) and fold it into the patch of your
> choice.  stg should check that the stack remains valid, possibly doing
> trivial adjustments to the higher patches.  The current tree should not
> be impacted.

Note that 'stg fold' uses git-apply-patch which doesn't take fuzzy
patches (a feature I began to like actually). Modifying the patch in
an editor might create some problems with applying.

--
Catalin
