From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: bash completion with colour hints
Date: Wed, 26 Sep 2012 17:00:21 +0200
Message-ID: <50631885.8090604@nieuwland.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000401000607070601090505"
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 17:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGtCt-0001HX-Hw
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 17:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642Ab2IZPHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 11:07:12 -0400
Received: from mail.nieuwland.nl ([87.251.35.136]:49422 "HELO nieuwland.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752879Ab2IZPHK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 11:07:10 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Sep 2012 11:07:10 EDT
Received: (qmail 5176 invoked by uid 453); 26 Sep 2012 15:00:23 -0000
X-Virus-Checked: Checked by ClamAV on nieuwland.nl
Received: from Unknown (HELO [192.168.216.232]) (192.168.216.232)
  (smtp-auth username soosthoek, mechanism plain)
  by nieuwland.nl (qpsmtpd/0.83) with (AES256-SHA encrypted) ESMTPSA; Wed, 26 Sep 2012 17:00:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206419>

This is a multi-part message in MIME format.
--------------000401000607070601090505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shawn

I only recently found the __git_ps1 function, but it wasn't directly 
able to replace my own contraption. I've modified the version I found 
after installing bash-completion in debian 6.

The patch is attached, it contains an escape character, so it is hard to 
include in plain text. I've gzipped it for convenience...

This is only a first step, I had a hard time figuring out what exactly 
the one-letter variables were doing (and still a bit unclear), so I'm 
sure this can be improved!

Anyway, the functionality of this patch is to show the output in green 
if the repo is up to date and red or other colours if it isn't.

Cheers

Simon

--------------000401000607070601090505
Content-Type: application/gzip;
 name="bash_git_completion_colour.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="bash_git_completion_colour.patch.gz"

H4sICIQWY1AAA2Jhc2hfZ2l0X2NvbXBsZXRpb25fY29sb3VyLnBhdGNoAI1T0W6bMBR9Dr+w
lzvK1HbUKYQmUzJVitSHtdK0TmunPVQTMmCCVcdGtlmEovz7bJOkJevWWQjCPT7H595DEEKw
oBoJSRcow4+DURSPUDRFownEk1kynV18GEa7BWE0iiIvDENHyrCqcrGsGdFU8APqOJqN/6TO
54DG07MJhOY+hfncgyPoVk0kkqQWimohWzDiVEHWgiJaU74AXRFbrIaqEqvvtdKS4CXkgpd0
8aTyC0uKM0aGpuSFu+pNCa1oYCUaVgCjjwQwB1wU1BrHDCrKNVBu1JhopP3V2mctTXf6ScZY
gU839+nXuzi9u779cXX7+fbb9c2Xe9ACMHDBidnfGhOsIUO4aqQkXLP2ScE20R2iAEsCFZZF
LgpS2DMtWDY8t6aGQ9eB6etegGqyJdVQY51XRM0sYAeZRCMzwzCJxmfJ2M1yYFaammzSWsWp
HVTabCflwJLah7kjLxyYa8BEbtrPU0mKy+M3D0m8PH5ebgljYuWQpI+wzLRogfgsuehDC0kI
d5xRH6gbab4Vh4z7SN7ijjE5qDOCpQWi5/VamrjKtBRyifWlH6zjGYKTd+p043uh3UZLeADE
wUAvxoU2Pvz8aOfN7fZuvx+sfHh7Cf77PQgOHRyet20x6NWDrVvfcQhT5K9sM+x/cU08e1Ou
Cdp3O6BOpcsmoK+Q1QFZObKL71Vuc8BtHLeL8WXyVsJ+ZV1WpaFYk8qIeWg3DeiFZt7yYJ0d
HUlSqvOK4EKdb4J1OQshKDeBDGp3BMkrAcHJXqE3wv8ROTW27D9g44H3G9fdo/T5BAAA
--------------000401000607070601090505--
