From: "Aneesh Kumar K.V" <aneesh.kumar@hp.com>
Subject: Re: [PATCH 2/2] Don't use excessive non-standard border width
Date: Tue, 28 Feb 2006 10:46:11 +0530
Message-ID: <20060228051611.GB5934@satan.india.hp.com>
References: <20060228045629.21880.19007.stgit@dv.roinet.com> <20060228045631.21880.27670.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 06:16:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDxDb-0001Vz-T5
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 06:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWB1FQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 00:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWB1FQN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 00:16:13 -0500
Received: from palrel12.hp.com ([156.153.255.237]:47288 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1750869AbWB1FQM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 00:16:12 -0500
Received: from localhost (unknown [15.76.101.80])
	by palrel12.hp.com (Postfix) with ESMTP id AF79836D16;
	Mon, 27 Feb 2006 21:16:11 -0800 (PST)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <20060228045631.21880.27670.stgit@dv.roinet.com>
User-Agent: mutt-ng/devel-r655 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16915>

On Mon, Feb 27, 2006 at 11:56:31PM -0500, Pavel Roskin wrote:
> From: Pavel Roskin <proski@gnu.org>
> 
> 
> ---
> 
>  contrib/gitview/gitview |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
> index aded7ed..00cb8ee 100755
> --- a/contrib/gitview/gitview
> +++ b/contrib/gitview/gitview
> @@ -492,7 +492,6 @@ class GitView:
>  	def construct_top(self):
>  		"""Construct the top-half of the window."""
>  		vbox = gtk.VBox(spacing=6)
> -		vbox.set_border_width(12)
>  		vbox.show()
>  
>  		menu_bar = gtk.MenuBar()
> @@ -574,7 +573,6 @@ class GitView:
>  	def construct_bottom(self):
>  		"""Construct the bottom half of the window."""
>  		vbox = gtk.VBox(False, spacing=6)
> -		vbox.set_border_width(12)
>  		(width, height) = self.window.get_size()
>  		vbox.set_size_request(width, int(height / 2.5))
>  		vbox.show()


I am not sure about this. I guess it looks much better with a border.

Not applied.

-aneesh
