From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: why the 'g' prefix on the SHA1 in git-describe output?
Date: Sat, 3 Nov 2007 14:56:47 +0100
Message-ID: <8c5c35580711030656h23d5910ah824de41a2cf4eafe@mail.gmail.com>
References: <871wb7a53d.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Jim Meyering" <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sat Nov 03 14:57:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoJUn-0003Au-38
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 14:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbXKCN4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 09:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbXKCN4s
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 09:56:48 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:48524 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbXKCN4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 09:56:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1297101wah
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qJmkZ6yNc523VjnEpyYDV+eAPXTUqi2omiYh3IAg+Fs=;
        b=Kqww1mrtJcs03S9T/pdNPfZTY6gktTLdgzulH7/igGqHKg2L+fKW9LgKqVp3e/vSB5yBzlLYI4Z4Zvroi+TBqXLKcQWFZnZYUo0QiYm2pq3n2L3Q029xmyi1Jfw5jYMVr//XzxzTiDcxXcj+MoPJtY84NyT0A0alZtj7n21cjhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=idTztFT1sp198WkutPXo1AaIN5bqULLz3+aC/RH8t5DirAWM+YRmHSsSI54SKubagibqyenu4U9nQ1KSzXUJzQ4CyWGqV3HKYP9LbHvPDDACNCwIcHAKYc39wwCCMVomVaI4DVEvhskTg6O0b0wNrwMfVoD9NLIWrCOzO2qXfzs=
Received: by 10.114.154.1 with SMTP id b1mr3022164wae.1194098207113;
        Sat, 03 Nov 2007 06:56:47 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 3 Nov 2007 06:56:47 -0700 (PDT)
In-Reply-To: <871wb7a53d.fsf@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63269>

On Nov 3, 2007 1:25 PM, Jim Meyering <jim@meyering.net> wrote:
> Can anyone tell me what motivated adding the 'g' prefix on the SHA1 in
> git-describe output?

I'm not sure what _motivated_ the 'g', but currently git-rev-parse
understands the output from git-describe _if_ the 'g' is present.

--
larsh
