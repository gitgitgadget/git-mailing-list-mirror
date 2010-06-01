From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: http-smart-backend: can clone, cannot push
Date: Tue, 1 Jun 2010 17:59:00 +0200
Message-ID: <AANLkTil5od-DIaK5H5UCxS2CCwGRnr2vQCfn167_PjXP@mail.gmail.com>
References: <E66CC81A-CCED-4D8E-AE7C-C02FB0AF6F6C@pelagicore.com>
	<AANLkTimqncJ7aqi_0AvjNimyIPsbVN1zSkAQ1LrPhwne@mail.gmail.com>
	<B61D22CA-45BA-49DA-984B-A7F7090FAE55@pelagicore.com>
	<AANLkTin43VO3FA9dEjAx9w6FRwLK7FpqqO5rA6wKFZgn@mail.gmail.com>
	<3A4DAEA3-C7F4-4163-9ABA-37443BB025AB@pelagicore.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeremiah Foster <jeremiah.foster@pelagicore.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 17:59:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJTs2-0007x8-8O
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 17:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153Ab0FAP7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 11:59:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38231 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab0FAP7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 11:59:08 -0400
Received: by wyi11 with SMTP id 11so1106361wyi.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=++OGNgxdH6gF2IOq15q15Pfu4wCP6Z2KbEJvU7xkCK4=;
        b=ovpvim1yFpAqE66jzHiIDDkK5n+NNQHAFbk2iifixGEnKwI4L80xjj9LVnBnvVlKI1
         ZlCPHmAj00mGYaNyMOORakaPrPL2Ji97qRGMt+Bn4pFNlXJKOdMcbHSqwl4buiZ4bdTY
         +7k7N7fWws1/80l+ZhjwnIeGDRNRo7fcEI6pk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=LD8pqlxYSSUCp/tNGyCCzxfwPhmXnhqWTIKXfwChV06U9R0JZhOk6iWHUzM3+yIpdQ
         AGJr0ZtloASgFLuZFz2t3XhVUDCX6fqijb4SbHI18rvTLkFEyBVnQo8FOwmF4v9vWz9+
         GxSu97mUuNTFXe/V6i02CNHqADXMnhtEjQo7g=
Received: by 10.216.91.12 with SMTP id g12mr5553222wef.78.1275407941037; Tue, 
	01 Jun 2010 08:59:01 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Tue, 1 Jun 2010 08:59:00 -0700 (PDT)
In-Reply-To: <3A4DAEA3-C7F4-4163-9ABA-37443BB025AB@pelagicore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148133>

On Tue, Jun 1, 2010 at 5:53 PM, Jeremiah Foster
<jeremiah.foster@pelagicore.com> wrote:
>
> On Jun 1, 2010, at 17:40, Tay Ray Chuan wrote:
>>
>> On Tue, Jun 1, 2010 at 11:24 PM, Jeremiah Foster
>> <jeremiah.foster@pelagicore.com> wrote:
>>>
>>> * The requested URL returned error: 403
>>
>> You're getting a 403 Forbidden here. What authentication method were
>> you expecting?
>
> I thought that by exporting "GIT_SSL_NO_VERIFY=true" that it would not matter.

This is about not verifying the SSL certificate, not the user.

-- 
Erik "kusma" Faye-Lund
