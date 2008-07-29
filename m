From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Hackontest ideas?
Date: Tue, 29 Jul 2008 08:55:32 +0700
Message-ID: <fcaeb9bf0807281855w3b06f624q18f5ac76a3bb405c@mail.gmail.com>
References: <20080729000103.GH32184@machine.or.cz>
	 <7vk5f5o6em.fsf@gitster.siamese.dyndns.org>
	 <20080729011404.GI32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 29 03:56:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNeS3-0003Qx-TW
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 03:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbYG2Bzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 21:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYG2Bze
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 21:55:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:15113 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYG2Bze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 21:55:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2223708fgg.17
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xIfZ6OYKkHDnB68eb586h0f/fnpv8IcYGsz7J0HV9E8=;
        b=nHfosBDzBjVQ2Z2bTnAGaHqsDBfTaVwy2UI9sM5uQVjw7lM9+Y4Iw49DEvqZMmwktF
         SSrhFR0JRrNvZVY8+YHACBVDMkx+2GYWvloT86CPDHXclpv6Arjtq8/IVELNvJHDJyE5
         qwvzZfarGXxAyhA4lWx0w9ltAIzsiuVEXsu0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cPS9VzSn3txurOQBAywVla2h3P9BJHFfDLFhLQYF/9f1sefBXokKLfCXPqLEIRgYj8
         2apyjBlh6o3F8vVKoypgBp+Q/BBBt0EZ67OsLt4C8J4Wb4Z7/JnltZ+XlcK8YqlZccUQ
         cX04jk5yKaxf0K9fmtL4skZ5bLLX7gZhNnCh4=
Received: by 10.86.26.11 with SMTP id 11mr3169735fgz.71.1217296532636;
        Mon, 28 Jul 2008 18:55:32 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Mon, 28 Jul 2008 18:55:32 -0700 (PDT)
In-Reply-To: <20080729011404.GI32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90547>

On 7/29/08, Petr Baudis <pasky@suse.cz> wrote:
> On Mon, Jul 28, 2008 at 05:55:45PM -0700, Junio C Hamano wrote:
>  > Petr Baudis <pasky@ucw.cz> writes:
>  >
>  > > (What feature in Git or a Git-related tool would you implement, given 24
>  > > hours staight and unlimited pizza supply?)
>  >
>  > "Use 'assume unchanged' bit to implement narrow checkout".
>
>
> I think Nguyen Thai Ngoc Duy is already working on this? (Though I think
>  he does not use the assume unchanged bit; but this will be likely done
>  before the end of September.)

You are welcome to do ;) I got to narrow checkout from subtree
checkout where 'assume unchanged' bit was unapplicable so my approach
is a bit different, but probably 'assume unchanged' bit is the right
way to go.

-- 
Duy
