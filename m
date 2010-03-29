From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: how to display a simplified graph of commits ?
Date: Mon, 29 Mar 2010 15:57:22 +0200
Message-ID: <adf1fd3d1003290657u64b4ef2fid8a6d94672085860@mail.gmail.com>
References: <20100329132439.GA734@aldebaran.xn--kwg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: David Madore <david+news@madore.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 15:57:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwFT7-0000ff-S7
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 15:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab0C2N5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 09:57:25 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:45025 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab0C2N5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 09:57:24 -0400
Received: by fxm23 with SMTP id 23so854134fxm.21
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 06:57:22 -0700 (PDT)
Received: by 10.103.239.19 with HTTP; Mon, 29 Mar 2010 06:57:22 -0700 (PDT)
In-Reply-To: <20100329132439.GA734@aldebaran.xn--kwg.net>
Received: by 10.103.4.14 with SMTP id g14mr2675719mui.84.1269871042377; Mon, 
	29 Mar 2010 06:57:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143474>

On Mon, Mar 29, 2010 at 3:24 PM, David Madore <david+news@madore.org> wrote:

[...]

>
> Is there another way I can restrict the set of commits to display,
> with any kind of graphical tool like gitk?

You can use gitk --simplify-by-decoration. It only shows the commits
with tags, plus some commits to make a meaningful graph. But it does
not work with a generic list of commits, the list of interesting
commits is always those with tags.

HTH,
Santi
