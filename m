From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: 'git fast-export' is crashing on the gcc repo
Date: Tue, 11 Dec 2007 21:35:04 +0100
Message-ID: <e5bfff550712111235q10177d9bif314580127a56d67@mail.gmail.com>
References: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:35:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2BpA-0000dN-Uj
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbXLKUfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbXLKUfH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:35:07 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:65365 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbXLKUfF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:35:05 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2160553rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 12:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UBASmrtP1MqAoL2kGnVAYUN+iD2ks8r4FLW/4AZZw1A=;
        b=qPkjeD3hQEGe1Y8TxQYI9sZpjIPmsW2iKrRGzdn4sggowEoTfF4U+xH7diL/Dvp71yIrznDTFiDapY0ej1H0cxO06ztd7UED3AxfNwTZnz+q0MwVvuruKk+Rkx+Nk23ASRhFLWCytAkYhWkdcEvHBnLpr05l9u7lxYA3RseSQNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SIonGfJVWbPBOdEIFq7/zJQTOwg1Viln1RfLc99iio1p2s2iTk39prWBF8H8UEdFv2zkR6UZYAkLALl0JTZxpmJ1UaK0FZKt1k7F3RqdkGEYD/uzE/XQKsTy29IcoSRHbLUSap9qwslMa06JUBhy0ZDpHFNbPReITTB2ErVDdoc=
Received: by 10.141.2.19 with SMTP id e19mr1541907rvi.1197405304664;
        Tue, 11 Dec 2007 12:35:04 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 11 Dec 2007 12:35:04 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67936>

On Dec 11, 2007 9:27 PM, Nicolas Pitre <nico@cam.org> wrote:
>
> And then running it again produced:
>
> fatal: Could not write blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391: Inappropriate ioctl for device
>
> adding to today's confusion.
>

GCC repo is turning out to be a very good test case indeed ;-)
