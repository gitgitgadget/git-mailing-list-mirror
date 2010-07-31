From: =?ISO-8859-1?Q?Daniel_Fran=E7a?= <daniel.franca@gmail.com>
Subject: Re: error commiting in Git
Date: Sat, 31 Jul 2010 19:25:29 -0300
Message-ID: <AANLkTi=n-J5rMOz0pkcxQZ7VgGs_EtXpotO=wZoDyz=C@mail.gmail.com>
References: <AANLkTimOZr8zq8uXdrzrpLMTDQqwJkZEyxB_zcWFEYBs@mail.gmail.com> 
	<AANLkTimqWF7gZHAXFOmz0URdDTF=CfMmjJrBwmFavUkK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 00:26:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfKVK-00056f-H9
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 00:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab0GaWZu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 18:25:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42831 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab0GaWZt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jul 2010 18:25:49 -0400
Received: by pwi5 with SMTP id 5so946354pwi.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=EYqlymBPAsAc5BEmowqWMRIQkFjEQ8Ed0qxHO5lQ6yA=;
        b=e781VS3TCqhTrWZqS7VGeS4PIzYbfP2p0xgqDmiV4BC7OzFqoraCXI5qDzlp0jT+d1
         7O/ITzXY5nf9emiyrIKifZZgEvlcbQjQ/fLyAPxRPjCDarltSFCzOzY/tl9Fa4/B/j1q
         DFcTCnzoFbktkcvBvQ6xESeZW9GDoNZNHFi7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=wWFWa0rPnEhLDAifya/2u8Ckj8Se4H5JP+OaUp4VIv3b0G3gKS28rzSrQDSgE62Czk
         APhrdnlbLZeMkXdr5WYh7+euIPS3FnDlmEJV2JAgNcFcTFZTUfIMNPHeE1OkjhWd3i2a
         oRq4z2+lRL66kDYYFcnNv1zOUC4oZWQo5KQNw=
Received: by 10.114.109.19 with SMTP id h19mr4549954wac.141.1280615149092; 
	Sat, 31 Jul 2010 15:25:49 -0700 (PDT)
Received: by 10.115.23.7 with HTTP; Sat, 31 Jul 2010 15:25:29 -0700 (PDT)
In-Reply-To: <AANLkTimqWF7gZHAXFOmz0URdDTF=CfMmjJrBwmFavUkK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152341>

Hi,
I recently migrate to Mac OS from Linux.
and now when I try to commito some file of my git project I get the
following error:
find: illegal option -- n
find: illegal option -- a
find: illegal option -- m
find: illegal option -- e
it seems to me that git calls find in a way that mac os doesn't support=
=2E
any idea how can I solve that?


Best Regards,
Daniel Fran=E7a
