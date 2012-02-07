From: compufreak <compufreak@gmail.com>
Subject: Re: User authentication in GIT
Date: Tue, 7 Feb 2012 13:31:19 +0100
Message-ID: <CAO54GHA0Usa7D=m012gnObXYpdTVTjeeZUp47xnCJ7cDaJqTqg@mail.gmail.com>
References: <1328595129258-7261349.post@n2.nabble.com> <1328615262741-7262113.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 13:31:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RukD7-0002O9-Ai
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 13:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255Ab2BGMbm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 07:31:42 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51663 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858Ab2BGMbk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 07:31:40 -0500
Received: by ggnh1 with SMTP id h1so3336548ggn.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 04:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6XPF2iLYvncLL872p4RAcQeEdW+L6X+hF4+EHDAe/uQ=;
        b=eYToMUObVw/Qo2TaN62Qm8k2yTTi8p+T9mXLdr+ncnL3CZiuGw4T3GmyHCvYKD14Bp
         7wflmvUdlLSNHXLM3tAh3k5zVHG9LB8pWcmzEnKK0P44oeApTfZMDCfNy/+5Bd18LhwO
         IrdHtOZ6XxTxN7Y0k4OYwDJQfvGAk/b8QhN6c=
Received: by 10.50.178.73 with SMTP id cw9mr18239099igc.23.1328617899284; Tue,
 07 Feb 2012 04:31:39 -0800 (PST)
Received: by 10.231.77.136 with HTTP; Tue, 7 Feb 2012 04:31:19 -0800 (PST)
In-Reply-To: <1328615262741-7262113.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190164>

Inline respon

On Tue, Feb 7, 2012 at 12:47 PM, supadhyay <supadhyay@imany.com> wrote:
> Hi Robin and Jakub,
> ...
> Robin:
> All users must have their own SSH key. You do not create keys for the=
m.
> My rely: can you please give some more idea about how it works.. I am=
 not
> getting this or if you can provide any link for this to understand.

SSH authentication can use private/public keys. The user generates a
keypair on their computer and gives you their public key, the private
key stays on their computer.
>
> Jakub:
> My reply: existing version control system used =C2=A0pserver protocol=
=2E
>
> You would still need for each user to generate their own SSH key.
> My reply: Do I need to store all end users sSH key in .ssh/authorized=
_keys
> file on GIT server?

If you were to do it manually, yes. But if you use gitolite [1], then
you add them to another git repository which handles everything for
you.

> --
> View this message in context: http://git.661346.n2.nabble.com/User-au=
thentication-in-GIT-tp7261349p7262113.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

[1]: https://github.com/sitaramc/gitolite
