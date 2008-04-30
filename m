From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout or merge, stash & restore submodules)
Date: Thu, 1 May 2008 01:21:16 +0800
Message-ID: <46dff0320804301021t59740377vece412ea71d67cf4@mail.gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
	 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
	 <32541b130804300947s6083156etc6514cc13c24af13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:22:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrG0M-00036Z-Ib
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757976AbYD3RVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 13:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757951AbYD3RVT
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:21:19 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:44552 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757869AbYD3RVS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:21:18 -0400
Received: by an-out-0708.google.com with SMTP id d40so127379and.103
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hFEu117OiJ4MgfGDKeZM6tksBSWbEkdBXl9SPwAgt64=;
        b=ghLHum8iayagwwXjcs8LcY2drObE47yDJHArVoZkHe34acxXzVixXsUU8dVeMHsglIkejOw2oOIBHn6hotycsDnHLp7BUDwYFkiDahhzX1e9UzWSndS1FO0NyRcQoxmxvKYROfdZbyHDZj4jBnQ7u8mFOpsmPlAfnrDwtGOKAQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g6plElx/9G0C3gENWSgIforj+Dl9a0QjmL3X7PrfyBhDi4593Z6AS0bhw6Chk94H2v4XsAK5zgxGpXtNPSgi+4Kb29SBFXlUIeReHXeqfGyz2ugWeNVvWZjQoJd/i4oaQxWQ9QLTqvdX7vuysk2ohcwhqtfP+dqRk+ON2KB0fcU=
Received: by 10.100.127.15 with SMTP id z15mr1668260anc.61.1209576076801;
        Wed, 30 Apr 2008 10:21:16 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Wed, 30 Apr 2008 10:21:16 -0700 (PDT)
In-Reply-To: <32541b130804300947s6083156etc6514cc13c24af13@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80851>

On Thu, May 1, 2008 at 12:47 AM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On 4/30/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  >  On Tue, 29 Apr 2008, Tim Harper wrote:

>
>  Not true.  If ".gitmodules" is different between branches, then
>  .git/config will have the wrong information.  I think this was the
>  reason for the "read .gitmodules directly and don't worry about
>  .git/config" discussion/patches earlier.

I tried hard to avoid 'git submodule init' in that series.
Unfortuately, few people agreed with me.


>  We had some discussion on the list earlier about having submodule
>  checkouts automatically acquire a branch name, so that commits don't
>  get lost as easily.  I was going to think about this more and
>  eventually submit a patch, but I haven't gotten to it yet.  Anyway,
>  the idea is that you have a branch by default, so that you don't end
>  up in the useless situation of not being on a branch, which encourages
>  checking in without being on a branch, in the first place.
>

I like this idea and it is very useful for me.


-- 
Ping Yin
