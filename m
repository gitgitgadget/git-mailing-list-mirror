From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [RFC] git reset --recover
Date: Tue, 4 Mar 2008 16:22:40 +0800
Message-ID: <46dff0320803040022r6babc3d2n745bc8a08b8bf197@mail.gmail.com>
References: <46dff0320803030659j2fa0325lf9c88b915ddb70da@mail.gmail.com>
	 <20080303170242.GA30361@hashpling.org>
	 <46dff0320803032121v54612b40ke953348e86daf1f@mail.gmail.com>
	 <76718490803032342k18f05d4dte76aacd9292a1233@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Charles Bailey" <charles@hashpling.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 09:23:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWSQj-0003xb-E6
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 09:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbYCDIWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 03:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbYCDIWn
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 03:22:43 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:43540 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbYCDIWn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 03:22:43 -0500
Received: by an-out-0708.google.com with SMTP id d31so125126and.103
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 00:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=izb6HSrRrov+bhxJnsFuEnz+3r7xC1yNtct9jAJWpuo=;
        b=O2xTB7hoyV3qWTMjcRJ6sFz+nve3+XVLqouMADdOLfAC8YgE17eCxg9T8r/QkZ+a73QKPR2nbKt8v7bxRQMI7eTri5lu3OWRBl8yZvQileZL6hFH7zhpPZ/ymlnpK/WDdNKCpaJqtorGV3GePw+ad/PCJ3aLI8184tROV/Ylwoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FrV7S1j9KWulAmhOcvSGeCBWcVkHkr2Hxm+xG8g/y9dfbZWfggqJ87q/jHg+UzG1klUPn4KVWMk4ZjtOYoo40yESI4jrcsurb2v70wcFlSDbJRi4JwxX6A4r6pxkqVu4WNsoBSilavLF2foFpfhG+sZGIigflfgecfa2Xf0Chx8=
Received: by 10.100.225.19 with SMTP id x19mr1873976ang.58.1204618960929;
        Tue, 04 Mar 2008 00:22:40 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Tue, 4 Mar 2008 00:22:40 -0800 (PST)
In-Reply-To: <76718490803032342k18f05d4dte76aacd9292a1233@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76047>

On Tue, Mar 4, 2008 at 3:42 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Tue, Mar 4, 2008 at 12:21 AM, Ping Yin <pkufranky@gmail.com> wrote:
>  > On Tue, Mar 4, 2008 at 1:02 AM, Charles Bailey <charles@hashpling.org> wrote:
>  >  >
>
> >  >  Does 'git fsck' report some dangling blobs?  If so (some of) them
>  >  >  should be the content of your missing files.
>  >  >
>  >  Good news. So can "--recover" help me find the lost blobs?
>
>  git fsck --lost-found. Look under .git/lost-found/other for your blobs.
>  Anything that's not 41 bytes is a file.
>
Thanks for pointing me that.
>  j.
>



-- 
Ping Yin
