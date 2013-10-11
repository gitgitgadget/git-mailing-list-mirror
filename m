From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess,mismatch] [PATCH v2] diff.c: keep arrow(=>) on show_stats()'s
 shortened filename part to make rename visible.
Date: Fri, 11 Oct 2013 11:19:17 -0700
Message-ID: <52584125.1090706@vilain.net>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 11 20:26:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUhQI-00069g-5t
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 20:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774Ab3JKS0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Oct 2013 14:26:46 -0400
Received: from tx.vilain.net ([74.50.57.245]:53867 "EHLO tx.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882Ab3JKS0q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 14:26:46 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Oct 2013 14:26:45 EDT
Received: from [192.168.1.136] (c-24-6-40-146.hsd1.ca.comcast.net [24.6.40.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tx.vilain.net (Postfix) with ESMTPSA id 0E2AF8330;
	Fri, 11 Oct 2013 19:19:19 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235918>

On 10/11/2013 06:07 AM, Yoshioka Tsuneo wrote:
> +				prefix_len =3D ((prefix_len >=3D 0) ? prefix_len : 0);
> +				strncpy(pre_arrow, arrow - prefix_len, prefix_len);
> +				pre_arrow[prefix_len] =3D '=A50';


This seems to be an encoding mistake; was this supposed to be an ASCII
arrow?

Sam
