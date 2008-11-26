From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Extra pair of double quotes in "git commit" output?
Date: Wed, 26 Nov 2008 01:06:34 +0100
Message-ID: <adf1fd3d0811251606t7f49eb84y53075427859bd26a@mail.gmail.com>
References: <20081126064906.6117@nanako3.lavabit.com>
	 <20081125232521.GC30942@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nanako Shiraishi" <nanako3@lavabit.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 01:08:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L57wk-0001vi-0S
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 01:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbYKZAGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 19:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbYKZAGh
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 19:06:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:3894 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbYKZAGg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 19:06:36 -0500
Received: by nf-out-0910.google.com with SMTP id d3so116582nfc.21
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 16:06:35 -0800 (PST)
Received: by 10.103.175.9 with SMTP id c9mr1857104mup.3.1227657994651;
        Tue, 25 Nov 2008 16:06:34 -0800 (PST)
Received: by 10.103.176.11 with HTTP; Tue, 25 Nov 2008 16:06:34 -0800 (PST)
In-Reply-To: <20081125232521.GC30942@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101698>

On Wed, Nov 26, 2008 at 12:25 AM, Jeff King <peff@peff.net> wrote:

[...]

>
> So I sympathize with the desire to remove the quotes, as they look bad
> and are obviously not too rare. But I'd like to find a solution which
> maintains a better visual separation between the subject and the other
> text than simply removing them.

Maybe just use the output of "git branch -v":

master d9a5491 foo: bar

or even literally:

* master d9a5491 [ahead 1] foo: bar

or to make the separation more evident:

[master d9a5491] foo: bar

Santi
