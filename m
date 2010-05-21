From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH RFC] Add a config verbose option fetch and push
Date: Fri, 21 May 2010 16:53:13 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483234EE2@xmail3.se.axis.com>
References: <4bf69283.47c1f10a.1ecf.1183@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Nathan W. Panike" <nathan.panike@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 21 16:53:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFTbQ-0007as-H6
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 16:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210Ab0EUOxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 10:53:19 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:50505 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758203Ab0EUOxR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 10:53:17 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o4LErEjM030444;
	Fri, 21 May 2010 16:53:14 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Fri, 21 May 2010 16:53:14 +0200
Thread-Topic: [PATCH RFC] Add a config verbose option fetch and push
Thread-Index: Acr47lVbWya6baW7TQWg37s0ZOD0hAABq3kQ
In-Reply-To: <4bf69283.47c1f10a.1ecf.1183@mx.google.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147460>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Nathan W. Panike
> Sent: den 21 maj 2010 15:26
> To: git@vger.kernel.org
> Subject: [PATCH RFC] Add a config verbose option fetch and push
> 
> ---
> There are a couple projects that I follow where I find it useful to always
> set the verbose flag.  Setting this in the configuration file would let me
> avoid the times I forget to set it on the command line. I decided to do both
> push and fetch at the same time.
> 
>  Documentation/config.txt |   10 ++++++++++
>  builtin/fetch.c          |    7 +++++++
>  builtin/push.c           |    7 +++++++
>  3 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 39140ba..8e8a760 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -860,6 +860,11 @@ fetch.unpackLimit::
>  	especially on slow filesystems.  If not set, the value of
>  	`transfer.unpackLimit` is used instead.
> 
> +fetch.verbose::
> +	If true, it is the same as setting "-v" on the command line. If it is
> +	false or not defined, git will use the command line parameters to
> +	decide the verboseness of fetch.
> +

Don't you usually use the configured option as the default, and 
then let the command line options override it (e.g., by specifying
--no-verbose).

//Peter
