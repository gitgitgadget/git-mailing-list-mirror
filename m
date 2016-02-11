From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 02/21] refs: add methods for misc ref operations
Date: Thu, 11 Feb 2016 08:45:12 +0100
Message-ID: <56BC3C08.2080003@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 08:52:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTm35-00029Y-R3
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 08:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbcBKHwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 02:52:20 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62603 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147AbcBKHwT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2016 02:52:19 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2016 02:52:18 EST
X-AuditID: 1207440f-d9fff70000007e44-60-56bc3c0b4b87
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id FC.91.32324.B0C3CB65; Thu, 11 Feb 2016 02:45:15 -0500 (EST)
Received: from [192.168.69.130] (p548D69E5.dip0.t-ipconnect.de [84.141.105.229])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1B7jDWe030397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 11 Feb 2016 02:45:14 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1454701462-3817-3-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqMttsyfM4OovK4v5m04wWnRd6Way
	+DehxoHZY8GmUo8Fz++ze3zeJBfAHMVtk5RYUhacmZ6nb5fAnbF//j/Ggi0cFbu3T2FqYHzH
	1sXIwSEhYCIxd3F4FyMXh5DAVkaJ/cf+MEM4F5gk3l9sBnI4OYQF3CVO737HAmKLCDhIXN51
	FKqolVHi7o1+dpAEs4CmxIm3d9lAbDYBXYlFPc1MILaEgJxEb/cksGZeAW2JjZ1XwOIsAqoS
	l3buYwSxRQVCJN5/fc4KUSMocXLmE7B6TgEPibWPGtgg5utJ7Lj+ixXClpdo3jqbeQKjwCwk
	LbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6JXm5miV5qSukmRkjo8u9g7Fov
	c4hRgINRiYf3R83uMCHWxLLiytxDjJIcTEqivC8+AYX4kvJTKjMSizPii0pzUosPMUpwMCuJ
	8O54DJTjTUmsrEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwiljvCRMSLEpN
	T61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VqfDEwWkFSPEB7P1gBtfMWFyTmAkUhWk8x
	KkqJ814FSQiAJDJK8+DGwhLSK0ZxoC+FebeBVPEAkxlc9yugwUwgD33fBTK4JBEhJdXA6L2S
	YfJpHsN/lgUy0hKvpu7WE5L/FFIWHDg36MB1PgWLzimvJ3594ir+7qps2cEaHo38kN5ZH0TW
	HXgwfY9/adyPs5uK+697CE/9bjqxYfLSpC+fX69kCE4UXr3l4dXAe/Oc32bX9LZs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285948>

On 02/05/2016 08:44 PM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Add ref backend methods for:
> resolve_ref_unsafe, verify_refname_available, pack_refs, peel_ref,
> create_symref, resolve_gitlink_ref.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/init-db.c    |  1 +
>  refs.c               | 36 ++++++++++++++++++++++++++++++++++++
>  refs/files-backend.c | 33 +++++++++++++++++++++++----------
>  refs/refs-internal.h | 23 +++++++++++++++++++++++
>  4 files changed, 83 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 07229d6..26e1cc3 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -8,6 +8,7 @@
>  #include "builtin.h"
>  #include "exec_cmd.h"
>  #include "parse-options.h"
> +#include "refs.h"

You can't see it in this diff's context, but there is already an
'#include "refs.h"' in this file.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
