From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Include links to feeds in HTML header only for '200 OK' response
Date: Tue, 21 Dec 2010 00:59:09 +0100
Message-ID: <201012210059.10829.jnareb@gmail.com>
References: <20101218195848.16201.67691.stgit@localhost.localdomain> <201012182248.40731.jnareb@gmail.com> <4D0D2D52.9000108@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Dec 21 00:59:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUpdT-0001Vo-DH
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 00:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689Ab0LTX7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 18:59:18 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:35011 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab0LTX7R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Dec 2010 18:59:17 -0500
Received: by fxm18 with SMTP id 18so3720787fxm.2
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 15:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1RYka1oqyTaIFm/5I8ttgPIHfpNU/m9NVQfxNOhGfTI=;
        b=pQYhOgGpYLkyPxO48ZHCe7guqQCDgd/xDaytFPEXHWuOHcPIcPRre1++QYjNjgibh6
         D0zFO/hYb47ZlS+ofyir74T5jlyo/sr5YvYiBYNcIRIJXNrOUiaApvDcKubv33X+LTtL
         wIKa3WxwmSQLw+PsSNswCRqaWKZz/3ZMc49CE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NVNxaF3ggzxqgXmFdZsO0r5MoajU1ypSjSaRst5sE1XNmWoiMLJ5WhHTTouT6/Nyzo
         wugATsTocFDRK7F5NCY/XalYIk2ZzyJzD/0hK6w6C9POtvjehQaFyoxpeFIOXsx8vgXZ
         Qtq2sZzyocfShUNywSAf6PACly0hyFD5I7mgE=
Received: by 10.223.79.72 with SMTP id o8mr5326180fak.97.1292889555693;
        Mon, 20 Dec 2010 15:59:15 -0800 (PST)
Received: from [192.168.1.13] (aehn132.neoplus.adsl.tpnet.pl [79.186.195.132])
        by mx.google.com with ESMTPS id a6sm818998fak.1.2010.12.20.15.59.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Dec 2010 15:59:13 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D0D2D52.9000108@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164018>

On Sat, 18 Dec 2010, J.H. wrote:
> On 12/18/2010 01:48 PM, Jakub Narebski wrote:
>> J.H. wrote:
>> 
>>> I've no objection, you can add a sign-off from me.
>> 
>> Errr... sign-off or ack?  Signed-off-by is about provenance of code...
> 
> Considering this has already been running on kernel.org - sign-off.
> 
> http://git.kernel.org/?p=git/warthog9/gitweb.git;a=commit;h=41d9c63ad27a8d3c95bf8bb1ec5876483d39fbd6

>From Documentation/SubmittingPatches:

  The sign-off is a simple line at the end of the explanation for
  the patch, which certifies that you wrote it or otherwise have
  the right to pass it on as a open-source patch.

So sign-off is about code provenance.  As I don't think that code goes
into official git/git.git repository managed by Junio via your
git/warthog9/gitweb.git repository, I don't quite see why it is *sign-off*
from you, and not ack (Acked-by:).

-- 
Jakub Narebski
Poland
