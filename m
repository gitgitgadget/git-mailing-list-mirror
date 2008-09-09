From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT PATCH] Force maven build to assume UTF-8 encoded source files
Date: Tue, 9 Sep 2008 08:05:19 +0600
Message-ID: <7bfdc29a0809081905o30951d93lb8005f75d31b6002@mail.gmail.com>
References: <1220903169-15190-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 04:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcsce-00025y-JU
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 04:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbYIICFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 22:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbYIICFV
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 22:05:21 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:35153 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbYIICFU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 22:05:20 -0400
Received: by gxk9 with SMTP id 9so9331756gxk.13
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 19:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hNrbi6ITD6CBRgM4XliDclrzYm0CfsFd7XnNwXl4/34=;
        b=v1TMsGS/QitY+Nmgcfgca3ycklDNeBsXS0nSUxss5XvlPHqhRuqLLXxSlE7EsaPyd7
         jW/wsbYarejqROnFuXcTdHvhkxNv3ocFuwuUGimoGoJPwq8ODHtHFiZoBdH0M/55NT/w
         9kVDtqy4rjSDuJjMChzuzCiXrsLyF7P6IrKv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AYy6ojFUETubRoIIqQtRlK+OwmFULU7jM8ZRG2XGzpD3PcCukmNhJFqCjOY0NMLCEC
         qUSjdRo3ExP1JxBbW1VAhAVWYen7esGT33L812vcQFc6q0gEBqSAu3Xrwf052eNPXr57
         /6XlbWpwghgoGjseLhBC0hR/EWCAyajVeIpPs=
Received: by 10.150.216.3 with SMTP id o3mr22394273ybg.221.1220925919091;
        Mon, 08 Sep 2008 19:05:19 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Mon, 8 Sep 2008 19:05:19 -0700 (PDT)
In-Reply-To: <1220903169-15190-1-git-send-email-robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95328>

On Tue, Sep 9, 2008 at 1:46 AM, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  jgit-maven/jgit/pom.xml |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> We had one unit test failing because of this.
>

Firstly thanks for the change, secondly sorry for the inconvenience.
Thirdly, I could not detect the issue because the tests were passing
in my end from Eclipse and Maven :(. Sorry and thanks once again.

Cheers,

Imran

> -- robin
>
> diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
> index fe9b0c5..8ea56ca 100644
> --- a/jgit-maven/jgit/pom.xml
> +++ b/jgit-maven/jgit/pom.xml
> @@ -155,6 +155,7 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>                 <configuration>
>                     <source>1.5</source>
>                     <target>1.5</target>
> +                   <encoding>UTF-8</encoding>
>                 </configuration>
>             </plugin>
>         </plugins>
> --
> 1.6.0.1.267.gec3a
>
>



-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
