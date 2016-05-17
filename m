From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] mv: free memory at the end if desired
Date: Tue, 17 May 2016 06:14:45 +0200
Message-ID: <573A9AB5.3010109@web.de>
References: <20160517032247.25092-1-sbeller@google.com>
 <20160517032247.25092-2-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>
To: Stefan Beller <sbeller@google.com>, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue May 17 06:15:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2WPj-00058Y-M3
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 06:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbcEQEPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 00:15:18 -0400
Received: from mout.web.de ([212.227.17.11]:56889 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbcEQEPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 00:15:17 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M0Qkb-1bsQ970z3V-00ubo8; Tue, 17 May 2016 06:15:12
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <20160517032247.25092-2-sbeller@google.com>
X-Provags-ID: V03:K0:HRCSSEabWqo/Dr+syJ51niUhGWMmWPBeyqHvbmO0h9GkU+8pFTC
 XeOBEVmYndkuUzzxC55Xfa0RbQfl7BzHYbs0hwy4GgZuxvPlZ9X06N9/EQKhXcFrSVYlwaZ
 KQDkbHEzcg52TFf0LdS+WiGDz9QodaXB7NtktZbb1k0Phr2oOJyloRc14KDM5j+nc5LDkV1
 CQCsbJkwcSS3xSabdNLXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fiSDcDBsl8U=:R2/7ft9AxpyJ/grczAN1So
 lrrbXZlRpqU5chKyY45TMWeTtEXPBBkabFD67GJPwH6/UViW8jsNKpS5LXcZQft/r32u+LVs9
 DvGSEXOxAV3cU8yG5wrm/tSM5R8YKE8GPULOXAPYuikStnA9XAz6o0N391x1FbAeNR4RuD8y2
 7LJCFYkopmKIEM3oAb93T5wKvcFv9+NLGDpnO4J8euVrVPmycg0swxAbK1bZV415NJtCDcEMT
 FR2rsVJpxAEZFH2Wl+PcPaSCJ49y6PNOeb57xXvZuVlc+OKnmHdqPcTa7ga2aehv8hweBZbdD
 bj+RrtAnR4BKlSXZG8TP3InNDZ4AxkR54qhSO/CDr2g/rp2nU3yRRBheQnpztsLN5c/diFhHE
 eDrryRsKrbjHzwovjlORGG46g0c09zFJ3a757I8g+yQ3yAdpY/Tj5cef0NyhjilcTAASWkUy7
 ZpO8y1QJxfaBSBWmQEYPbTAvrdtZQYRzGe8uRNXsX7h0YLW8fye5NeBH2NO6AGs1OpaltTPQR
 5k+QkkEw86AlJBH9smxCSV+tBuKu1osSJke2QxLQCZsC7+arv4yQEGlWLb8VZ2JMVTqsqArbN
 4WaLTV1Wuc5KnNlLUUw7iVWfds1eu1OFYP5S/nt4lPyTHHS3tO/uh7jxQ2PI3zMFfFmZMrnUe
 JZvtF6/Zstm0GGDFvfneSDjsunfA+dXCufV1dWGr8gq9fqt35FGDprM1PiZcYvhKSYRtP8dQz
 lbGXdoZqcaiuRhvgv1paJsg7kgavnQh01aY3Fp+C7bpFIc3zZgAfPcuGwhOFBesoFj74sb9+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294852>

 >[PATCH 1/3] mv: free memory at the end if desired
s/desired/DEVELOPER/
