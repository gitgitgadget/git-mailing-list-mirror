From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 2/3] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sat, 1 Mar 2008 19:04:12 +0800
Message-ID: <46dff0320803010304i7c9593f0l48620c4a3518314@mail.gmail.com>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
	 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
	 <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
	 <7vabli7vhr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 12:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVPWk-0005DH-5C
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 12:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178AbYCALEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 06:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbYCALEO
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 06:04:14 -0500
Received: from hs-out-0708.google.com ([64.233.178.242]:3713 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbYCALEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 06:04:13 -0500
Received: by hs-out-0708.google.com with SMTP id 4so851488hsl.5
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 03:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4Dn19LqLQjwRVkSTBcagOB6kOpydLwkyrouU8caeANQ=;
        b=NLglEOMffKYJ+QFI4w70oOrz5zAHcWtf+AG6wguQ8rVwB0G8x+hu/72/DTwPy3OM+azRIXCtlOCi5FWBSBz477TxQUTbYdMHPdK19EDFsCt75QwC2yLZlXAI4W/kMC4f6nIK6ZJ0iN/uWkRK3ZU8V7hQ3cMR+5Xy9ifn7KdVzpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RC/iTLR+DK2N9Y8g82q+LNRk3XTtzW5z0vltaL/gMvxMDF/gmIpDo5owIEzU622I17rbO8usgko4AMk7zjlSfPkcS8ulBi8zYPcO/D48RgIJ+7ie9mpqLvBTQrLysR33NPurjD34MYgDhEarjU4t+a5R6PqSGq/oJ5KQM9Y9W1I=
Received: by 10.100.93.19 with SMTP id q19mr22477811anb.50.1204369452488;
        Sat, 01 Mar 2008 03:04:12 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sat, 1 Mar 2008 03:04:12 -0800 (PST)
In-Reply-To: <7vabli7vhr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75654>

On Sat, Mar 1, 2008 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>
>  > +             check_src=$(echo $mod_src | grep 160000)
>  > +             check_dst=$(echo $mod_dst | grep 160000)
>
>  Huh?  Do you mean "test $mod_src = ':160000'" and such?
>
Yeah. There are 2 places needing test this. I don't find a better way


-- 
Ping Yin
