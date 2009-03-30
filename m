From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 4/4] Rename push.default to push.style
Date: Mon, 30 Mar 2009 14:50:26 +0200
Message-ID: <adf1fd3d0903300550h6150b8b2xb51da64f35305a78@mail.gmail.com>
References: <1238281804-30290-1-git-send-email-santi@agolina.net>
	 <1238281804-30290-5-git-send-email-santi@agolina.net>
	 <20090330080115.GA19142@pvv.org>
	 <alpine.DEB.1.00.0903301021540.7534@intel-tinevez-2-302>
	 <adf1fd3d0903300200v65393b1bif0050392aa44652e@mail.gmail.com>
	 <20090330102739.GA5163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 14:52:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoGy8-0002Nu-TL
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 14:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbZC3Mua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 08:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbZC3Mua
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 08:50:30 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:35203 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbZC3Mu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 08:50:29 -0400
Received: by mu-out-0910.google.com with SMTP id g7so854802muf.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 05:50:26 -0700 (PDT)
Received: by 10.103.252.17 with SMTP id e17mr1685844mus.14.1238417426584; Mon, 
	30 Mar 2009 05:50:26 -0700 (PDT)
In-Reply-To: <20090330102739.GA5163@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115146>

2009/3/30 Jeff King <peff@peff.net>:
> On Mon, Mar 30, 2009 at 11:00:03AM +0200, Santi B=E9jar wrote:
>
>> >> This configuration variable says what push should do
>> >> when no refspec is given and none are configured, so the word "de=
fault"
>> >> should be in there at least. Maybe "defaultref" would have been b=
etter?
>>
>> I don't see the point of the word default, a lot of configuration is
>> to set the default value. Git has branch.name.remote, not
>> branch.name.defaultremote, or user.email, not user.defaultemail,...
>
> The usual case is two layers of options: command line and config
> options. Thus "git push <remote>" overrides "branch.*.remote".
>
> But in this case there are actually _three_ layers: command line,
> branch.*.push, and now push.default. I think a name like "push.mode"
> doesn't make clear the fact that it will never be looked at if you ha=
ve
> "branch.*.push" set up.
>
> I think you have a point that "default" is vague, but "defaultMode"
> would be better than simply "mode".

Thanks, it makes sense. Now I find defaultMode better than 'mode'.

Santi
