From: =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2015, #01; Wed, 1)
Date: Wed, 22 Jul 2015 13:16:44 +0200
Message-ID: <55AF7B9C.4000108@gmail.com>
References: <xmqqzj3f5wtr.fsf@gitster.dls.corp.google.com>
 <55AE8ACF.6090508@gmail.com>
 <alpine.LSU.2.00.1507220957350.16350@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Wed Jul 22 13:17:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHs1X-00087V-24
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 13:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934026AbbGVLRO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2015 07:17:14 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37296 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933440AbbGVLRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 07:17:13 -0400
Received: by wibud3 with SMTP id ud3so167124595wib.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=TfmSwkECRYoxKrspHQY98/+343shLY8F+z5scCt66PA=;
        b=JX8vBuH4YUGhX3rgknNOTy6iffg6WCFy9tsHdKkneE61yn5V1gTWO6lolCyxcS99hS
         s9HeBvHySUZYgDDhlE2Wuaw7RxKJLr331yGVe6/gCPkCXGTAjytR9wH0hgJ+eng9s/B/
         88bmgrYLy1pC/ZHvgk851JkUT49omFOHeWk4LhJXM5X0oLrSxg1HU+cQCRaWhuS0xOOm
         SvPwtDuOd/BXQvJuOHBt4gP4ZeVcTnWhW/u6G+7aztlfpBOtqUaBjHOsMZSMkxiV2aPP
         gnKuQEjakwvG2C4nOvLrdl7lSkAZ5KHyU9r17ScucjS6AO2jDTQWxnaYU37h5HkRA3uD
         80pg==
X-Received: by 10.194.122.132 with SMTP id ls4mr3874262wjb.130.1437563831788;
        Wed, 22 Jul 2015 04:17:11 -0700 (PDT)
Received: from [192.168.1.53] (afu155.neoplus.adsl.tpnet.pl. [83.25.150.155])
        by smtp.googlemail.com with ESMTPSA id pd7sm1864573wjb.27.2015.07.22.04.17.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 04:17:10 -0700 (PDT)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <alpine.LSU.2.00.1507220957350.16350@hermes-1.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274441>

On 2015-07-22, Tony Finch wrote:
> Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>=20
> Thanks for the review!
>=20
>>> * tf/gitweb-project-listing (2015-03-19) 5 commits
>>>  - gitweb: make category headings into links when they are director=
ies
>>>  - gitweb: optionally set project category from its pathname
>>>  - gitweb: add a link under the search box to clear a project filte=
r
>>>  - gitweb: if the PATH_INFO is incomplete, use it as a project_filt=
er
>>>
>>>  Update gitweb to make it more pleasant to deal with a hierarchical
>>>  forest of repositories.
>=20
> By the way, you can see this patch series in action at
> https://git.csx.cam.ac.uk/x/ucs/

Thanks. I don't have my computer set up completely yet (after reinstall=
).

>> Second one, "gitweb: if the PATH_INFO is incomplete, use it as a
>> project_filter" looks interesting and quite useful. Though it doesn'=
t
>> do much: it allows for handcrafted URL, and provides mechanism to
>> create breadcrumbs. It doesn't use this feature in its output...
>> Well, I think it doesn't: I cannot check it at this moment.
>=20
> Hmm, I think this means I need a better commit message.
>=20
> This patch fixes the ugly query-parameter URLs in the breadcrumbs tha=
t
> you get even in path-info mode. Have a look at the breadcrumbs on the
> following pages:
>=20
> https://git.csx.cam.ac.uk/g/ucs/git/git.git (unpatched)
> https://git.csx.cam.ac.uk/x/ucs/git/git.git (patched)
>=20
> If you click on the antepenultimate /git/ in the breadcumbs you get q=
uery
> parameters without the patch and path_info with the patch. With the p=
atch
> the breadcrumbs match the URL.

Ah. Yes, the patch itself looks all right, but it definitely needs
a better (or at least enhanced) commit message if it is about *adding*
path info counterpart to existing query parameter project_filter -
- it is (also) about uniquifying URLs used in breadcrumbs when gitweb
uses path info links.

Current version is (if I have it correctly):

    gitweb: if the PATH_INFO is incomplete, use it as a project_filter

    Previously gitweb would ignore partial PATH_INFO. For example,
    it would produce a project list for the top URL
        https://www.example.org/projects/
    and a project summary for
        https://www.example.org/projects/git/git.git
    but if you tried to list just the git-related projects with
        https://www.example.org/projects/git/
    you would get a list of all projects, same as the top URL.

    As well as fixing that omission, this change also makes gitweb
    generate PATH_INFO-style URLs for project filter links, such
    as in the breadcrumbs.

A question about implementation: why emptying $path_info in
evaluate_path_info()?

>> What is missing is a support for query parameters path, and not only
>> path info.
>=20
> Query parameter support is already present, in the form of project
> filters.
>=20
>> Thought some thought is needed for generating (or not) breadcrumbs
>> if path_info is turned off.
>=20
> That already works in unpatched gitweb.

Right.

>> The third, "gitweb: add a link under the search box to clear a proje=
ct
>> filter" notices a problem... then solves it in strange way. IMVHO
>> a better solution would be to add "List all projects" URL together
>> with " / " (or other separator) conditionally, if $project_filter
>> is set. Or have "List all projects" and add "List projects$limit"
>> if $project_filter is set.
>=20
> Yes, that is exactly what the patch does. I used a suffix "if" to ali=
gn
> the print statements and markup:
> +           if $project_filter;
>=20
> Compare and contrast the search box on these pages:
>=20
> https://git.csx.cam.ac.uk/g/ucs/?a=3Dproject_list;pf=3Du/fanf2
> https://git.csx.cam.ac.uk/x/ucs/u/fanf2/
>=20
> Perhaps you would prefer the following?
>=20
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5549,10 +5549,14 @@ sub git_project_search_form {
>               "</span>\n" .
>               $cgi->submit(-name =3D> 'btnS', -value =3D> 'Search') .
>               $cgi->end_form() . "\n" .
> -             $cgi->a({-href =3D> href(project =3D> undef, searchtext=
 =3D> undef,
> -                                    project_filter =3D> $project_fil=
ter)},
> -                     esc_html("List all projects$limit")) . "<br />\=
n";
> -       print "</div>\n";
> +             $cgi->a({-href =3D> $my_uri}, esc_html("List all projec=
ts"));
> +       if ($project_filter) {
> +               print " / " .
> +                   $cgi->a({-href =3D> href(project =3D> undef, acti=
on =3D> "project_list",
> +                                          project_filter =3D> $proje=
ct_filter)},
> +                           esc_html("List projects$limit"));
> +       }
> +       print "<br />\n</div>\n";
>  }
>=20
>  # entry for given @keys needs filling if at least one of keys in lis=
t

Yes, it is eminently more readable.=20

Postfix controls are discouraged, especially with multi-line constructs
c.f. Perl::Critic::Policy::ControlStructures::ProhibitPostfixControls

>> The last two, which form the crux of this patch series, looks like
>> a good idea, though not without a few caveats. I am talking here
>> only about conceptual level, not about how it is coded (which has
>> few issues as well):
>>
>> - I think that non-bare repositories "repo/.git" should be
>>   treated as one directory entry, i.e. gitweb should not create
>>   a separate category for "repo/".  This is admittedly a corner
>>   case, but useful for git-instaweb
>=20
> Yes, that's a bug, thanks for spotting it!

Well, more like a corner case. With "repo/.git" there wouldn't be
other repositories in "repo/"... well, except for old-style submodules
for git-instaweb.
=20
>> - I think that people would want to be able to configure how
>>   many levels of directory hierarchy gets turned into categories.
>>   Perhaps only top level should be turned into category? Deep
>>   hierarchies means deep categories (usually with very few
>>   repositories) with current implementation.
>=20
> Good question. I was assuming flat-ish directory hierarchies, but tha=
t's
> clearly not very true, e.g. https://git.kernel.org/cgit/
>=20
> I think it would be right to make this a %feature since categories al=
ready
> nearly fit the %feature per-project override style.

On the other hand $projects_list_group_categories is a global gitweb
configuration variable, and $projects_list_directory_is_category was
patterned after it.

Note that cgit, when using first part of path (first directory) as
project category, it strips it from project name, but indents project
list... though I am not sure if it would work if more than first
directory is used for category (as in this case there can be repos
mixed with categories: "sub/repo.git", "sub/foo/bar.git", "sub/foo/baz.=
git")

> I will send a new version of the series shortly.

A few thoughts about implementation:
- the comment above $projects_list_directory_is_category does not
  mention that it needs $projects_list_group_categories to function
- $project_list_default_category is moved to inside of
  git_get_project_category(), which is not mentioned in commit message
  (and might be good independent cleanup)
- with more complicated rules it would be worth moving the core of
  work into newly created git_get_category_from_path(), or something
  like that
- can we turn category header into link even if the category didn't
  came from $projects_list_directory_is_category?
- even if $projects_list_directory_is_category is true, the category
  could came from 'category' file, or otherwise manually set category,
  though I wonder how we can easily detect this...

Best regards
--=20
Jakub Nar=C4=99bski
