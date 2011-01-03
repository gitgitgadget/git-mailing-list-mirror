From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] Fix typos in the documentation
Date: Mon, 03 Jan 2011 12:57:30 -0500
Message-ID: <1294077450.12519.15.camel@drew-northup.unet.maine.edu>
References: <20110102055653.GI19818@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 03 18:58:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZoff-0007wz-12
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 18:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab1ACR6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 12:58:09 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:60430 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab1ACR6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 12:58:08 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p03HvYRB007144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 3 Jan 2011 12:57:39 -0500
In-Reply-To: <20110102055653.GI19818@gmx.de>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p03HvYRB007144
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1294682263.76342@mRYECwmsrgGAPN3Q07citg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164453>


On Sun, 2011-01-02 at 06:56 +0100, Ralf Wildenhues wrote:

<snip for clarity> 
> diff --git a/Documentation/RelNotes/1.7.4.txt b/Documentation/RelNotes/1.7.4.txt
> index b736d39..5619641 100644
> --- a/Documentation/RelNotes/1.7.4.txt
> +++ b/Documentation/RelNotes/1.7.4.txt
> @@ -8,12 +8,11 @@ Updates since v1.7.3
>     docbook-xsl >= 1.73. If you have older versions, you can set
>     ASCIIDOC7 and ASCIIDOC_ROFF, respectively.
>  
> - * The option parsers of various commands that create new branch (or
> + * The option parsers of various commands that create new branches (or
>     rename existing ones to a new name) were too loose and users were
> -   allowed to call a branch with a name that begins with a dash by
> -   creative abuse of their command line options, which only lead to
> -   burn themselves.  The name of a branch cannot begin with a dash
> -   now.
> +   allowed to give a branch a name that begins with a dash by creative
> +   abuse of their command line options, which only led to burn themselves.
> +   The name of a branch cannot begin with a dash now.
>  
>   * System-wide fallback default attributes can be stored in
>     /etc/gitattributes; core.attributesfile configuration variable can
<snip for clarity>

Ralf,
Perhaps that should be:

- * The option parsers of various commands that create new branch (or
+ * The option parsers of various commands that create new branches (or
    rename existing ones to a new name) were too loose and users were
-   allowed to call a branch with a name that begins with a dash by
-   creative abuse of their command line options, which only lead to
-   burn themselves.  The name of a branch cannot begin with a dash
-   now.
+   allowed to give a branch a name that begins with a dash by creative
+   abuse of their command line options, which only led to burning 
+   themselves. The name of a branch cannot begin with a dash now.

(for consistency)?

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
