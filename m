From: David Turner <dturner@twopensource.com>
Subject: Re: mktree: multiple same-named objects
Date: Wed, 27 Aug 2014 17:48:33 -0400
Organization: Twitter
Message-ID: <1409176113.15185.0.camel@leckie>
References: <1409114517.13351.6.camel@leckie>
	 <CACsJy8C+Vg98XjvfSodWLG33mmQOhUrmVKO25EO2MSBTzgttFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:48:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMl58-0002o6-Q7
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 23:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbaH0Vsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 17:48:38 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:45765 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbaH0Vsh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 17:48:37 -0400
Received: by mail-qc0-f171.google.com with SMTP id x3so89000qcv.16
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 14:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=S8x+coq3bEHb/l0qVJ6WdMJ3TUD2KUlFLOU2igX/Wxs=;
        b=VBEq5luwHbWeLQtj8bTOHDcqgcuCLAbvtx9JDm/2RFLVEo3P82jNkaAAazu6BTNYR1
         AbBgRFpuFuLrwu/FDGosoKwrf/sySuIsnhMdv6aNo9U0/jtPz+0b+W8+cyfDF8+lsaT/
         wfmE3cAiWtxZPNa7D8d+f1lnFhGpW56uPdvpBhyq4lYTgICUShY754d/NxJVjYrlDfn1
         9lA7K0mhHF6S09BbLEkmxMZ/qnljthlOP/m2crNz44W3yU2613i/emYXW5VK/i/pBZzE
         0/ZqO8PjX3ztiB70/grmceld7Lse/18NFnjrTPlvPXU4vPg1j6K9E4oh4fC22rDbAKwP
         F08w==
X-Gm-Message-State: ALoCoQnHzfEYQtB/qQKxx83QEyavbW3IWavf7pyBSqo+jqFCF/ZeDadVRhKzyq0GpdvWbGiUPOwJ
X-Received: by 10.140.38.73 with SMTP id s67mr11960005qgs.4.1409176115608;
        Wed, 27 Aug 2014 14:48:35 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id e2sm4722146qas.38.2014.08.27.14.48.34
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 27 Aug 2014 14:48:34 -0700 (PDT)
In-Reply-To: <CACsJy8C+Vg98XjvfSodWLG33mmQOhUrmVKO25EO2MSBTzgttFQ@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256049>

On Wed, 2014-08-27 at 12:01 +0700, Duy Nguyen wrote:
> On Wed, Aug 27, 2014 at 11:41 AM, David Turner <dturner@twopensource.com> wrote:
> > Summary: git mktree ought to forbid this, and possibly there ought to be
> > other checks (for instance, when unpacking) to prevent this.
> 
> Does fsck detect this (because we ought to fix fsck first if it does not)?

Yes, it does.
