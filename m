From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 5/5] RelNotes: wordsmithing
Date: Thu, 23 Apr 2015 14:47:47 +0200
Message-ID: <5538E9F3.7040702@alum.mit.edu>
References: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu> <1429792070-22991-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:48:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlGY1-0007NM-UF
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 14:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757780AbbDWMr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 08:47:56 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49449 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756587AbbDWMrz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2015 08:47:55 -0400
X-AuditID: 12074413-f79f26d0000030e7-47-5538e9f429a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id F7.BD.12519.4F9E8355; Thu, 23 Apr 2015 08:47:49 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97208.dip0.t-ipconnect.de [79.201.114.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3NCllnF012655
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 23 Apr 2015 08:47:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1429792070-22991-6-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqPv1pUWowcSljBZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xo0Z05kK9rJVXHr/nb2BcQtrFyMnh4SAiUTT
	wi+MELaYxIV769m6GLk4hAQuM0qsXb2bHcI5xyTxZd0CFpAqXgFtiRsrtjGD2CwCqhL/J59n
	B7HZBHQlFvU0M4HYogJBEq3XpjJC1AtKnJz5BKxXREBNYmLbISCbg4NZQFyi/x9YWFhAX+LQ
	hIlg5UICtRL73q8DO45TwFVi3b7NYOOZBfQkdlz/xQphy0s0b53NPIFRYBaSDbOQlM1CUraA
	kXkVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkiYCu9g3HVS7hCjAAejEg/v
	i2yLUCHWxLLiytxDjJIcTEqivGdvAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8O65DZTjTUms
	rEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwXn0B1ChYlJqeWpGWmVOCkGbi
	4AQZziUlUpyal5JalFhakhEPitT4YmCsgqR4gPa+A2nnLS5IzAWKQrSeYtTluDPl/yImIZa8
	/LxUKXHegyBFAiBFGaV5cCtgSekVozjQx8K890GqeIAJDW7SK6AlTEBLZi4FW1KSiJCSamDc
	rM2rcPJ7/3a1lrM6qekP3qtuvZ75xuvvnOVuyy5bCOn9cRfflD6Zi4frcafckYR/WzoY9s8X
	6RM4qWC63z/tWV9H//6QjnjXn+3bdHhnHVT87Z+x9Ee7y0W5E/L8zhO3iGw+5Lgl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267689>

On 04/23/2015 02:27 PM, Michael Haggerty wrote:
> Make many textual tweaks to the 2.4.0 release notes.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/RelNotes/2.4.0.txt | 336 ++++++++++++++++++++-------------------
>  1 file changed, 172 insertions(+), 164 deletions(-)
> 
> diff --git a/Documentation/RelNotes/2.4.0.txt b/Documentation/RelNotes/2.4.0.txt
> index 7b23ca3..cde64be 100644
> --- a/Documentation/RelNotes/2.4.0.txt
> +++ b/Documentation/RelNotes/2.4.0.txt
> [...]

Oh, I just noticed that many of the same blurbs appear in the release
notes for the maintenance versions. Once there is agreement on how many
of the changes to accept, the analogous changes should probably be made
in those other files.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
