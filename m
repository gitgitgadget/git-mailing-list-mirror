From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] git-submodule - Allow adding a submodule in-place
Date: Tue, 4 Mar 2008 13:16:41 +0800
Message-ID: <46dff0320803032116t63327fe6u3e9be269b0cec347@mail.gmail.com>
References: <1204596383-4040-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mark Levedahl" <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 06:17:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWPWj-0007bb-Bb
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 06:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbYCDFQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 00:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbYCDFQo
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 00:16:44 -0500
Received: from hs-out-0708.google.com ([64.233.178.249]:14113 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbYCDFQn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 00:16:43 -0500
Received: by hs-out-0708.google.com with SMTP id 4so825638hsl.5
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 21:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Bls+wjwqI/+yvcSOVouB03MwKs0YN26EAGge39Sjgzg=;
        b=WVL2p3eE/GMSLsFC5BrKFK0f6BInXT4wUk0JeyL4Vj3BMErrT054DHt/3jmPOLhymoFH5rxfEE1P9kvtQ2eTNMuP27Y21DoqalnqgjgjLmc3d359my91LQjbkygyRrGIjVtPh7gDoGhTbHWCuCtZPsI7of0AcW6GUTDy2OQJCSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KJYMQS7CfOLrnjLhzobOuQHRt4I1JJqPOdhRpbc/jgJBud4wBYhbl8lvq8ueVWBNIfK5wfOP4EbPsKyVYHAoKJCxyyGIPEAKK52d4ew06AsqGFiHabciZMKLBQSpDAb/+8dQhngSaSaByBkTWBiyYZx97oq5wmrG/LhfDXXBpj8=
Received: by 10.100.43.13 with SMTP id q13mr1400196anq.18.1204607801714;
        Mon, 03 Mar 2008 21:16:41 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Mon, 3 Mar 2008 21:16:41 -0800 (PST)
In-Reply-To: <1204596383-4040-1-git-send-email-mlevedahl@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76034>

On Tue, Mar 4, 2008 at 10:06 AM, Mark Levedahl <mlevedahl@gmail.com> wrote:
>
>  +-r remote::
>  +       Name of remote to use or define when working with relative submodules
>  +       (i.e., submodules whose url is given relative to the top-level
>  +       project). If this value is undefined, the top-level project's
>  +       branch.<name>.remote is used, and if that is undefined the default
>  +       "origin" is used. The remote will be defined in each relative
>  +       submodule as needed by appending the relative url to the top level
>  +       project's url. This option has no effect upon submodules defined
>  +       using an absolute url: such project's are cloned using the default
>  +       "origin," and are updated using the submodule's branch.<name>.remote
>  +       machinery and defaulting to "origin."
>  +

Is this part necessary?
>  --
>  1.5.4.3.438.g4c6f8
>
>



-- 
Ping Yin
