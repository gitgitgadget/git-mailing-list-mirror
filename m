From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 30/43] refs-be-files.c: add method to expire reflogs
Date: Mon, 05 Oct 2015 10:41:09 +0200
Message-ID: <561237A5.4030603@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-31-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 10:48:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj1Rg-0006wU-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 10:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbbJEIs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 04:48:26 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:62683 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751480AbbJEIs0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 04:48:26 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2015 04:48:25 EDT
X-AuditID: 12074411-f797e6d000007df3-44-561237a76af7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 96.AA.32243.7A732165; Mon,  5 Oct 2015 04:41:11 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t958f9FH000681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 04:41:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-31-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42IRYndR1F1uLhRmcLOF02L+phOMFl1Xupkc
	mDwWPL/P7vF5k1wAUxS3TVJiSVlwZnqevl0Cd8bXpy+YC+YxV8zYfoylgXEHUxcjJ4eEgInE
	jSmnoGwxiQv31rN1MXJxCAlcZpRo+X0NyjnHJHHq6Sk2kCpeAW2J2a+eMoPYLAKqEj/vHwKL
	swnoSizqaQabJCoQJLFi+QtGiHpBiZMzn7CA2CICDhKXdx0F6xUW8JZYf/AdM8SCNkaJS91X
	gYo4ODgFvCRaLkuB1DAL6EnsuP6LFcKWl9j+dg7zBEb+WUjGzkJSNgtJ2QJG5lWMcok5pbm6
	uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsYISEpuINxxkm5Q4wCHIxKPLwSSYJhQqyJZcWV
	uYcYJTmYlER5a3WEwoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8L4yA8rxpiRWVqUW5cOkpDlY
	lMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR4G0AaBYtS01Mr0jJzShDSTBycIMO5pESKU/NS
	UosSS0sy4kExGV8MjEqQFA/Q3nlge4sLEnOBohCtpxh1ORb8uL2WSYglLz8vVUqctx+kSACk
	KKM0D24FLAG9YhQH+liY1xOkigeYvOAmvQJawgS0pF8ebElJIkJKqoGx9tynkPfKa49fnLF9
	18LJb/i1p1oLaW486b7NQ17tkgVLNdPCsw+t/x2zLZ85uSPtLDvfHUEzt5uLr554G7dUMEJO
	Vf2Tk4bB5njTpo7Ft5Tkd67ZcIfr1y9vqetMex7Ktf90SNhwwXUN53vZmkOSBlvX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279046>

On 09/29/2015 12:02 AM, David Turner wrote:
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 13 +++++++------
>  refs.c          | 12 ++++++++++++
>  refs.h          |  7 +++++++
>  3 files changed, 26 insertions(+), 6 deletions(-)
> [...]

I think it would be natural to squash this into the previous patch.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
