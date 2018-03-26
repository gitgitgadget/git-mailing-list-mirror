Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4E11F404
	for <e@80x24.org>; Mon, 26 Mar 2018 23:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeCZXjP (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 19:39:15 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:44570 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeCZXjN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 19:39:13 -0400
Received: by mail-yb0-f175.google.com with SMTP id v8-v6so6991987ybm.11
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Pm971du4afJIgzPnwflhuzzme7MfHwH9z/OqINIC4Ag=;
        b=C0Rh84YaiSDrU2bo/84Ol+ey9iVM0tTBGvId04fL8qZ0HXintgFSIzRlUFy2ZjLy4x
         fdK7lZ9xfZCVSfkcyIb0oeTkrYS1PJoqVf+yk7Jvptfg/PLjK2uxV5AbObIeS7FHhL06
         hOVFVRb6XWkPDtp/Hj0HxqSVhDW7iMVOiHAIK0TY+y/I9OZn3RoyRNAUa6gSUU6FXXsO
         3APDm9TW21FwI/FKv+qkRaYG7E2YAiOuycIaZ+SQUM8LqVq9dT27qZsLTrx8YZofyycj
         ghbYZ4+08RmyG846+Ndi9zoT/EgWiq46A7aRQPcHxddwkTxXp9sgxqTkTKWI2QilMS5q
         ptLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Pm971du4afJIgzPnwflhuzzme7MfHwH9z/OqINIC4Ag=;
        b=uU7NVbCTPPiZlajThRCWR0DB08/iFfdF9ipw4CLrE9QEsLAQgFSd31h8zrlQdIIuX2
         ZBKmzgKHfNd7L1LIncpEMvn7lSL1AHUOjZ1h5lq1JIQKYnXNSGgOrocgxyGN6YEYUvI/
         DDozcOzgsLuGHZVc1sv5XN9CK9T5GWli4qev35RNFZsQWx8rxZOGPfYb2fcKyUtrTSaS
         11LrLKH26NiBYRLp9FydyVjNpy/Gi58rn9SiDZ5WEKJG1qKmUvnLkTaqCl1cSH/vic6r
         qtDKasBROTJwVtxs7vPbJPc9Rng020GXjLAOC4Ymv2eQu07GxEp8Vvm7wO7DHlPay3Vg
         KbnQ==
X-Gm-Message-State: AElRT7GpzQxAW4BBsXI6OIIyd8z2zD846xKCeBdduk5x+PzmJP02R+A0
        9U46DZJlNSahk7DXyJt53SK1NkmMv7WxJBGoFGuN/Cs0
X-Google-Smtp-Source: AG47ELsCWRNYIDrmGq+zQ0WHgh20gLa9uJBkciqh7x9WM+u1Y73PeR8/xJqlk8jmzpX1BrXxd6iK2paYnKvFgNCfptE=
X-Received: by 2002:a25:e80d:: with SMTP id k13-v6mr15403967ybd.334.1522107552543;
 Mon, 26 Mar 2018 16:39:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 26 Mar 2018 16:39:11
 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 16:39:11 -0700
Message-ID: <CAGZ79kbAOcwaRzjuMtZ_HVsYvUr_7UAPbOcnrmPgsdE19q=PrQ@mail.gmail.com>
Subject: Fwd: New Defects reported by Coverity Scan for git
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

coverity scan failed for the last couple month (since Nov 20th)
without me noticing, I plan on running it again nightly for the
Git project.

Anyway, here are issues that piled up (in origin/pu) since then.

Stefan


---------- Forwarded message ----------
From:  <scan-admin@coverity.com>
Date: Mon, Mar 26, 2018 at 4:24 PM
Subject: New Defects reported by Coverity Scan for git
To: sbeller@google.com


Hi,

Please find the latest report on new defect(s) introduced to git found
with Coverity Scan.

44 new defect(s) introduced to git found with Coverity Scan.
32 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 44 defect(s)


** CID 1433546:  Resource leaks  (RESOURCE_LEAK)
/t/helper/test-path-utils.c: 236 in cmd__path_utils()


___________________________________________________________________________=
_____________________________
*** CID 1433546:  Resource leaks  (RESOURCE_LEAK)
/t/helper/test-path-utils.c: 236 in cmd__path_utils()
230             if (argc >=3D 4 && !strcmp(argv[1], "prefix_path")) {
231                     const char *prefix =3D argv[2];
232                     int prefix_len =3D strlen(prefix);
233                     int nongit_ok;
234                     setup_git_directory_gently(&nongit_ok);
235                     while (argc > 3) {
>>>     CID 1433546:  Resource leaks  (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "prefix_path(prefix, p=
refix_len, argv[3])" leaks it.
236                             puts(prefix_path(prefix, prefix_len, argv[3=
]));
237                             argc--;
238                             argv++;
239                     }
240                     return 0;
241             }

** CID 1433545:  Security best practices violations  (STRING_OVERFLOW)
/merge-recursive.c: 1955 in check_dir_renamed()


___________________________________________________________________________=
_____________________________
*** CID 1433545:  Security best practices violations  (STRING_OVERFLOW)
/merge-recursive.c: 1955 in check_dir_renamed()
1949                                                      struct
hashmap *dir_renames)
1950     {
1951            char temp[PATH_MAX];
1952            char *end;
1953            struct dir_rename_entry *entry;
1954
>>>     CID 1433545:  Security best practices violations  (STRING_OVERFLOW)
>>>     You might overrun the 4096-character fixed-size string "temp" by co=
pying "path" without checking the length.
1955            strcpy(temp, path);
1956            while ((end =3D strrchr(temp, '/'))) {
1957                    *end =3D '\0';
1958                    entry =3D dir_rename_find_entry(dir_renames, temp);
1959                    if (entry)
1960                            return entry;

** CID 1433544:  Resource leaks  (RESOURCE_LEAK)
/builtin/submodule--helper.c: 66 in print_default_remote()


___________________________________________________________________________=
_____________________________
*** CID 1433544:  Resource leaks  (RESOURCE_LEAK)
/builtin/submodule--helper.c: 66 in print_default_remote()
60              die(_("submodule--helper print-default-remote takes no
arguments"));
61
62      remote =3D get_default_remote();
63      if (remote)
64              printf("%s\n", remote);
65
>>>     CID 1433544:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "remote" going out of scope leaks the storage it points to=
.
66      return 0;
67     }
68
69     static int starts_with_dot_slash(const char *str)
70     {
71      return str[0] =3D=3D '.' && is_dir_sep(str[1]);

** CID 1433543:  Null pointer dereferences  (NULL_RETURNS)
/merge-recursive.c: 812 in was_dirty()


___________________________________________________________________________=
_____________________________
*** CID 1433543:  Null pointer dereferences  (NULL_RETURNS)
/merge-recursive.c: 812 in was_dirty()
806             int dirty =3D 1;
807
808             if (o->call_depth || !was_tracked(path))
809                     return !dirty;
810
811             ce =3D cache_file_exists(path, strlen(path), ignore_case);
>>>     CID 1433543:  Null pointer dereferences  (NULL_RETURNS)
>>>     Dereferencing a null pointer "ce".
812             dirty =3D (ce->ce_stat_data.sd_mtime.sec > 0 &&
813                      verify_uptodate(ce, &o->unpack_opts) !=3D 0);
814             return dirty;
815     }
816
817     static int make_room_for_path(struct merge_options *o, const char *=
path)

** CID 1433542:  Error handling issues  (CHECKED_RETURN)
/merge-recursive.c: 2162 in apply_directory_rename_modifications()


___________________________________________________________________________=
_____________________________
*** CID 1433542:  Error handling issues  (CHECKED_RETURN)
/merge-recursive.c: 2162 in apply_directory_rename_modifications()
2156             * "NOTE" in update_stages(), doing so will modify the curr=
ent
2157             * in-memory index which will break calls to
would_lose_untracked()
2158             * that we need to make.  Instead, we need to just
make sure that
2159             * the various conflict_rename_*() functions update the ind=
ex
2160             * explicitly rather than relying on unpack_trees() to
have done it.
2161             */
>>>     CID 1433542:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "get_tree_entry" without checking return value (as is done =
elsewhere 13 out of 16 times).
2162            get_tree_entry(&tree->object.oid,
2163                           pair->two->path,
2164                           &re->dst_entry->stages[stage].oid,
2165                           &re->dst_entry->stages[stage].mode);
2166
2167            /* Update pair status */

** CID 1433541:  Resource leaks  (RESOURCE_LEAK)
/t/helper/test-path-utils.c: 246 in cmd__path_utils()


___________________________________________________________________________=
_____________________________
*** CID 1433541:  Resource leaks  (RESOURCE_LEAK)
/t/helper/test-path-utils.c: 246 in cmd__path_utils()
240                     return 0;
241             }
242
243             if (argc =3D=3D 4 && !strcmp(argv[1], "strip_path_suffix"))=
 {
244                     char *prefix =3D strip_path_suffix(argv[2], argv[3]=
);
245                     printf("%s\n", prefix ? prefix : "(null)");
>>>     CID 1433541:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "prefix" going out of scope leaks the storage it points to=
.
246                     return 0;
247             }
248
249             if (argc =3D=3D 3 && !strcmp(argv[1], "print_path")) {
250                     puts(argv[2]);
251                     return 0;

** CID 1433540:  Null pointer dereferences  (REVERSE_INULL)
/upload-pack.c: 834 in process_deepen_since()


___________________________________________________________________________=
_____________________________
*** CID 1433540:  Null pointer dereferences  (REVERSE_INULL)
/upload-pack.c: 834 in process_deepen_since()
828     static int process_deepen_since(const char *line, timestamp_t
*deepen_since, int *deepen_rev_list)
829     {
830             const char *arg;
831             if (skip_prefix(line, "deepen-since ", &arg)) {
832                     char *end =3D NULL;
833                     *deepen_since =3D parse_timestamp(arg, &end, 0);
>>>     CID 1433540:  Null pointer dereferences  (REVERSE_INULL)
>>>     Null-checking "deepen_since" suggests that it may be null, but it h=
as already been dereferenced on all paths leading to the check.
834                     if (!end || *end || !deepen_since ||
835                         /* revisions.c's max_age -1 is special */
836                         *deepen_since =3D=3D -1)
837                             die("Invalid deepen-since: %s", line);
838                     *deepen_rev_list =3D 1;
839                     return 1;

** CID 1433539:  Null pointer dereferences  (FORWARD_NULL)


___________________________________________________________________________=
_____________________________
*** CID 1433539:  Null pointer dereferences  (FORWARD_NULL)
/t/helper/test-json-writer.c: 278 in scripted()
272             struct json_writer jw =3D JSON_WRITER_INIT;
273             int k;
274
275             if (!strcmp(argv[0], "@object"))
276                     jw_object_begin(&jw);
277             else if (!strcmp(argv[0], "@array"))
>>>     CID 1433539:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing "&jw" to "jw_array_begin", which dereferences null "jw.leve=
ls".
278                     jw_array_begin(&jw);
279             else
280                     die("first script term must be '@object' or
'@array': '%s'", argv[0]);
281
282             for (k =3D 1; k < argc; k++) {
283                     const char *a_k =3D argv[k];

** CID 1433538:  Null pointer dereferences  (FORWARD_NULL)


___________________________________________________________________________=
_____________________________
*** CID 1433538:  Null pointer dereferences  (FORWARD_NULL)
/t/helper/test-sha1-array.c: 23 in cmd__sha1_array()
17              const char *arg;
18              struct object_id oid;
19
20              if (skip_prefix(line.buf, "append ", &arg)) {
21                      if (get_oid_hex(arg, &oid))
22                              die("not a hexadecimal SHA1: %s", arg);
>>>     CID 1433538:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing "&array" to "oid_array_append", which dereferences null "ar=
ray.oid".
23                      oid_array_append(&array, &oid);
24              } else if (skip_prefix(line.buf, "lookup ", &arg)) {
25                      if (get_oid_hex(arg, &oid))
26                              die("not a hexadecimal SHA1: %s", arg);
27                      printf("%d\n", oid_array_lookup(&array, &oid));
28              } else if (!strcmp(line.buf, "clear"))

** CID 1433537:    (FORWARD_NULL)
/merge-recursive.c: 1796 in handle_directory_level_conflicts()
/merge-recursive.c: 1791 in handle_directory_level_conflicts()


___________________________________________________________________________=
_____________________________
*** CID 1433537:    (FORWARD_NULL)
/merge-recursive.c: 1796 in handle_directory_level_conflicts()
1790                            strbuf_release(&head_ent->new_dir);
1791                            string_list_append(&remove_from_merge,
1792
merge_ent->dir)->util =3D merge_ent;
1793                            strbuf_release(&merge_ent->new_dir);
1794                    } else if (tree_has_path(head, head_ent->dir)) {
1795                            /* 2. This wasn't a directory rename
after all */
>>>     CID 1433537:    (FORWARD_NULL)
>>>     Dereferencing null pointer "string_list_append(&remove_from_head, h=
ead_ent->dir)".
1796                            string_list_append(&remove_from_head,
1797
head_ent->dir)->util =3D head_ent;
1798                            strbuf_release(&head_ent->new_dir);
1799                    }
1800            }
1801
/merge-recursive.c: 1791 in handle_directory_level_conflicts()
1785                        !merge_ent->non_unique_new_dir &&
1786                        !strbuf_cmp(&head_ent->new_dir,
&merge_ent->new_dir)) {
1787                            /* 1. Renamed identically; remove it
from both sides */
1788                            string_list_append(&remove_from_head,
1789
head_ent->dir)->util =3D head_ent;
1790                            strbuf_release(&head_ent->new_dir);
>>>     CID 1433537:    (FORWARD_NULL)
>>>     Dereferencing null pointer "string_list_append(&remove_from_merge, =
merge_ent->dir)".
1791                            string_list_append(&remove_from_merge,
1792
merge_ent->dir)->util =3D merge_ent;
1793                            strbuf_release(&merge_ent->new_dir);
1794                    } else if (tree_has_path(head, head_ent->dir)) {
1795                            /* 2. This wasn't a directory rename
after all */
1796                            string_list_append(&remove_from_head,

** CID 1433536:    (RESOURCE_LEAK)
/t/helper/test-delta.c: 34 in cmd__delta()
/t/helper/test-delta.c: 48 in cmd__delta()
/t/helper/test-delta.c: 75 in cmd__delta()
/t/helper/test-delta.c: 78 in cmd__delta()


___________________________________________________________________________=
_____________________________
*** CID 1433536:    (RESOURCE_LEAK)
/t/helper/test-delta.c: 34 in cmd__delta()
28              return 1;
29      }
30
31      fd =3D open(argv[2], O_RDONLY);
32      if (fd < 0 || fstat(fd, &st)) {
33              perror(argv[2]);
>>>     CID 1433536:    (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
34              return 1;
35      }
36      from_size =3D st.st_size;
37      from_buf =3D mmap(NULL, from_size, PROT_READ, MAP_PRIVATE, fd, 0);
38      if (from_buf =3D=3D MAP_FAILED) {
39              perror(argv[2]);
/t/helper/test-delta.c: 48 in cmd__delta()
42      }
43      close(fd);
44
45      fd =3D open(argv[3], O_RDONLY);
46      if (fd < 0 || fstat(fd, &st)) {
47              perror(argv[3]);
>>>     CID 1433536:    (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
48              return 1;
49      }
50      data_size =3D st.st_size;
51      data_buf =3D mmap(NULL, data_size, PROT_READ, MAP_PRIVATE, fd, 0);
52      if (data_buf =3D=3D MAP_FAILED) {
53              perror(argv[3]);
/t/helper/test-delta.c: 75 in cmd__delta()
69              return 1;
70      }
71
72      fd =3D open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
73      if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
74              perror(argv[4]);
>>>     CID 1433536:    (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
75              return 1;
76      }
77
78      return 0;
/t/helper/test-delta.c: 78 in cmd__delta()
72      fd =3D open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
73      if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
74              perror(argv[4]);
75              return 1;
76      }
77
>>>     CID 1433536:    (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
78      return 0;

** CID 1433535:  Error handling issues  (CHECKED_RETURN)
/builtin/grep.c: 491 in grep_cache()


___________________________________________________________________________=
_____________________________
*** CID 1433535:  Error handling issues  (CHECKED_RETURN)
/builtin/grep.c: 491 in grep_cache()
485             int name_base_len =3D 0;
486             if (repo->submodule_prefix) {
487                     name_base_len =3D strlen(repo->submodule_prefix);
488                     strbuf_addstr(&name, repo->submodule_prefix);
489             }
490
>>>     CID 1433535:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "repo_read_index" without checking return value (as is done=
 elsewhere 4 out of 5 times).
491             repo_read_index(repo);
492
493             for (nr =3D 0; nr < repo->index->cache_nr; nr++) {
494                     const struct cache_entry *ce =3D repo->index->cache=
[nr];
495                     strbuf_setlen(&name, name_base_len);
496                     strbuf_addstr(&name, ce->name);

** CID 1433534:  Resource leaks  (RESOURCE_LEAK)
/t/helper/test-mktemp.c: 12 in cmd__mktemp()


___________________________________________________________________________=
_____________________________
*** CID 1433534:  Resource leaks  (RESOURCE_LEAK)
/t/helper/test-mktemp.c: 12 in cmd__mktemp()
6
7     int cmd__mktemp(int argc, const char **argv)
8     {
9       if (argc !=3D 2)
10              usage("Expected 1 parameter defining the temporary
file template");
11
>>>     CID 1433534:  Resource leaks  (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "xstrdup(argv[1])" lea=
ks it.
12      xmkstemp(xstrdup(argv[1]));
13
14      return 0;

** CID 1433533:    (RESOURCE_LEAK)
/t/helper/test-delta.c: 48 in cmd__delta()
/t/helper/test-delta.c: 55 in cmd__delta()
/t/helper/test-delta.c: 69 in cmd__delta()
/t/helper/test-delta.c: 75 in cmd__delta()
/t/helper/test-delta.c: 78 in cmd__delta()


___________________________________________________________________________=
_____________________________
*** CID 1433533:    (RESOURCE_LEAK)
/t/helper/test-delta.c: 48 in cmd__delta()
42      }
43      close(fd);
44
45      fd =3D open(argv[3], O_RDONLY);
46      if (fd < 0 || fstat(fd, &st)) {
47              perror(argv[3]);
>>>     CID 1433533:    (RESOURCE_LEAK)
>>>     Variable "from_buf" going out of scope leaks the storage it points =
to.
48              return 1;
49      }
50      data_size =3D st.st_size;
51      data_buf =3D mmap(NULL, data_size, PROT_READ, MAP_PRIVATE, fd, 0);
52      if (data_buf =3D=3D MAP_FAILED) {
53              perror(argv[3]);
/t/helper/test-delta.c: 55 in cmd__delta()
49      }
50      data_size =3D st.st_size;
51      data_buf =3D mmap(NULL, data_size, PROT_READ, MAP_PRIVATE, fd, 0);
52      if (data_buf =3D=3D MAP_FAILED) {
53              perror(argv[3]);
54              close(fd);
>>>     CID 1433533:    (RESOURCE_LEAK)
>>>     Variable "from_buf" going out of scope leaks the storage it points =
to.
55              return 1;
56      }
57      close(fd);
58
59      if (argv[1][1] =3D=3D 'd')
60              out_buf =3D diff_delta(from_buf, from_size,
/t/helper/test-delta.c: 69 in cmd__delta()
63      else
64              out_buf =3D patch_delta(from_buf, from_size,
65                                    data_buf, data_size,
66                                    &out_size);
67      if (!out_buf) {
68              fprintf(stderr, "delta operation failed (returned NULL)\n")=
;
>>>     CID 1433533:    (RESOURCE_LEAK)
>>>     Variable "from_buf" going out of scope leaks the storage it points =
to.
69              return 1;
70      }
71
72      fd =3D open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
73      if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
74              perror(argv[4]);
/t/helper/test-delta.c: 75 in cmd__delta()
69              return 1;
70      }
71
72      fd =3D open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
73      if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
74              perror(argv[4]);
>>>     CID 1433533:    (RESOURCE_LEAK)
>>>     Variable "from_buf" going out of scope leaks the storage it points =
to.
75              return 1;
76      }
77
78      return 0;
/t/helper/test-delta.c: 78 in cmd__delta()
72      fd =3D open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
73      if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
74              perror(argv[4]);
75              return 1;
76      }
77
>>>     CID 1433533:    (RESOURCE_LEAK)
>>>     Variable "from_buf" going out of scope leaks the storage it points =
to.
78      return 0;

** CID 1433532:    (RESOURCE_LEAK)
/t/helper/test-delta.c: 75 in cmd__delta()
/t/helper/test-delta.c: 78 in cmd__delta()
/t/helper/test-delta.c: 75 in cmd__delta()


___________________________________________________________________________=
_____________________________
*** CID 1433532:    (RESOURCE_LEAK)
/t/helper/test-delta.c: 75 in cmd__delta()
69              return 1;
70      }
71
72      fd =3D open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
73      if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
74              perror(argv[4]);
>>>     CID 1433532:    (RESOURCE_LEAK)
>>>     Variable "out_buf" going out of scope leaks the storage it points t=
o.
75              return 1;
76      }
77
78      return 0;
/t/helper/test-delta.c: 78 in cmd__delta()
72      fd =3D open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
73      if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
74              perror(argv[4]);
75              return 1;
76      }
77
>>>     CID 1433532:    (RESOURCE_LEAK)
>>>     Variable "out_buf" going out of scope leaks the storage it points t=
o.
78      return 0;
/t/helper/test-delta.c: 75 in cmd__delta()
69              return 1;
70      }
71
72      fd =3D open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
73      if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
74              perror(argv[4]);
>>>     CID 1433532:    (RESOURCE_LEAK)
>>>     Variable "out_buf" going out of scope leaks the storage it points t=
o.
75              return 1;
76      }
77
78      return 0;

** CID 1433531:  Null pointer dereferences  (FORWARD_NULL)


___________________________________________________________________________=
_____________________________
*** CID 1433531:  Null pointer dereferences  (FORWARD_NULL)
/builtin/submodule--helper.c: 1045 in module_deinit()
1039                                       module_deinit_options);
1040            }
1041
1042            if (!argc && !all)
1043                    die(_("Use '--all' if you really want to
deinitialize all submodules"));
1044
>>>     CID 1433531:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing "&list" to "module_list_compute", which dereferences null "=
list.entries".
1045            if (module_list_compute(argc, argv, prefix, &pathspec,
&list) < 0)
1046                    BUG("module_list_compute should not choke on
empty pathspec");
1047
1048            info.prefix =3D prefix;
1049            if (quiet)
1050                    info.flags |=3D OPT_QUIET;

** CID 1433530:    (FORWARD_NULL)


___________________________________________________________________________=
_____________________________
*** CID 1433530:    (FORWARD_NULL)
/run-command.c: 574 in trace_add_env()
568             for (e =3D deltaenv; e && *e; e++) {
569                     struct strbuf key =3D STRBUF_INIT;
570                     char *equals =3D strchr(*e, '=3D');
571
572                     if (equals) {
573                             strbuf_add(&key, *e, equals - *e);
>>>     CID 1433530:    (FORWARD_NULL)
>>>     Passing "&envs" to "string_list_insert", which dereferences null "e=
nvs.items".
574                             string_list_insert(&envs,
key.buf)->util =3D equals + 1;
575                     } else {
576                             string_list_insert(&envs, *e)->util =3D NUL=
L;
577                     }
578                     strbuf_release(&key);
579             }
/run-command.c: 576 in trace_add_env()
570                     char *equals =3D strchr(*e, '=3D');
571
572                     if (equals) {
573                             strbuf_add(&key, *e, equals - *e);
574                             string_list_insert(&envs,
key.buf)->util =3D equals + 1;
575                     } else {
>>>     CID 1433530:    (FORWARD_NULL)
>>>     Passing "&envs" to "string_list_insert", which dereferences null "e=
nvs.items".
576                             string_list_insert(&envs, *e)->util =3D NUL=
L;
577                     }
578                     strbuf_release(&key);
579             }
580
581             /* "unset X Y...;" */

** CID 1433529:  Control flow issues  (DEADCODE)
/upload-pack.c: 1419 in upload_pack_v2()


___________________________________________________________________________=
_____________________________
*** CID 1433529:  Control flow issues  (DEADCODE)
/upload-pack.c: 1419 in upload_pack_v2()
1413                            send_shallow_info(&data);
1414
1415                            packet_write_fmt(1, "packfile\n");
1416                            create_pack_file();
1417                            state =3D FETCH_DONE;
1418                            break;
>>>     CID 1433529:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "case FETCH_DONE:".
1419                    case FETCH_DONE:
1420                            continue;
1421                    }
1422            }
1423
1424            upload_pack_data_clear(&data);

** CID 1433528:  Null pointer dereferences  (FORWARD_NULL)


___________________________________________________________________________=
_____________________________
*** CID 1433528:  Null pointer dereferences  (FORWARD_NULL)
/convert.c: 411 in encode_to_git()
405              * the content. Let's answer with "yes", since an encoding =
was
406              * specified.
407              */
408             if (!buf && !src)
409                     return 1;
410
>>>     CID 1433528:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "src" to "validate_encoding", which dereferenc=
es it.
411             if (validate_encoding(path, enc, src, src_len, die_on_error=
))
412                     return 0;
413
414             trace_encoding("source", path, enc, src, src_len);
415             dst =3D reencode_string_len(src, src_len, default_encoding,=
 enc,
416                                       &dst_len);

** CID 1433527:  Control flow issues  (DEADCODE)
/fetch-pack.c: 1396 in do_fetch_pack_v2()


___________________________________________________________________________=
_____________________________
*** CID 1433527:  Control flow issues  (DEADCODE)
/fetch-pack.c: 1396 in do_fetch_pack_v2()
1390                            process_section_header(&reader, "packfile",=
 0);
1391                            if (get_pack(args, fd, pack_lockfile))
1392                                    die(_("git fetch-pack: fetch failed=
."));
1393
1394                            state =3D FETCH_DONE;
1395                            break;
>>>     CID 1433527:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "case FETCH_DONE:".
1396                    case FETCH_DONE:
1397                            continue;
1398                    }
1399            }
1400
1401            oidset_clear(&common);


___________________________________________________________________________=
_____________________________
To view the defects in Coverity Scan visit,
https://u2389337.ct.sendgrid.net/wf/click?upn=3D08onrYu34A-2BWcWUl-2F-2BfV0=
V05UPxvVjWch-2Bd2MGckcRb8HAP5hlBzHe8sORKm64S-2F81GsNbRdSrOteP-2FXoviMkw-3D-=
3D_PwiGIFugGOKqSZ6DZhASdI2SvWKInry4kHBXrJUc9pmXl6RPFKKio5QDumyeOncb-2B03DyH=
ottfRb-2BR0vAZZ-2BouFuqkpeG83Y-2BMRBesAVhj5GrGot1mbZe20ytg0ii7TqV60O843zCVE=
bFTCr2Fj7-2Byv7sYi9qWRfEPYF5wF-2BAudpsWONlHafz3S2f-2F0Lk0mNQz1ZEGGEFx2qj7TN=
c4JugAxaJzb7JKTcIW0OPzH-2BQxU-3D
